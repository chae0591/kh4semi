package servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import beans.QnaTmpFileDao;
import beans.QnaTmpFileDto;

@WebServlet(urlPatterns = "/qna_tmp_file/receive.do")
public class QnaFileUploadServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			수신 : req로 불가능하기 때문에 새로운 해석기를 생성해야 한다(MultipartRequest) - cos.jar 필요
			String path = "C:/upload";
			int max = 10 * 1024 * 1024;//10MB
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
//			수신 폴더 생성
			File dir = new File(path);
			dir.mkdirs();
			
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
//			계산 : 파일의 주요 정보들을 데이터베이스에 저장
//			= 파일이 아닌 기존 파라미터들은 mRequest.getParameter("")로 수신하면 된다(명령 동일)
//			= 파일데이터 명령은 따로 존재
//			= 저장된 파일명은 mRequest.getFileSystemName("파라미터명") 으로 수신
//			= 업로드한 파일명은 mRequest.getOriginalFileName("파라미터명") 으로 수신
//			= 저장된 파일 객체를 꺼내는 명령은 mRequest.getFile("파라미터명")
//			= 파일 유형은 mRequest.getContentType("파라미터명") 으로 수신
			
			QnaTmpFileDto qnaFileDto = new QnaTmpFileDto();
			qnaFileDto.setSave_name(mRequest.getFilesystemName("f"));
			qnaFileDto.setUpload_name(mRequest.getOriginalFileName("f"));
			File target = mRequest.getFile("f");
			qnaFileDto.setFile_size(target.length());
			qnaFileDto.setFile_type(mRequest.getContentType("f"));
			
			QnaTmpFileDao qnaFileDao = new QnaTmpFileDao();
			int file_no = qnaFileDao.getSequence();
			qnaFileDto.setFile_no(file_no);
			qnaFileDao.writeWithPrimaryKey(qnaFileDto);
			
			String imgUrl = req.getContextPath() + "/qna_tmp_file/download.do?file_no=" + file_no;

//			resp.sendRedirect(imgUrl);
			//http://localhost:8888/semi/file/download.do?file_no=1
//			출력 : 다른 페이지
			String json = "{ "
//					+ "\"isSuccess\":\"true\", "
					+ "\"file_no\": \"" + file_no + "\"" + ","
					+ "\"imgUrl\": \"" + imgUrl + "\""
					+ "}";
			
			resp.setContentType("application/json");
			resp.getWriter().write(json);
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
