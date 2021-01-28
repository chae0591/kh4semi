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

import beans.TipTmpFileDao;
import beans.TipTmpFileDto;


@WebServlet(urlPatterns = "/tip_tmp_file/receive.do")
public class TipFileUploadServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			String path = "C:/upload";
			int max = 10 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			

			File dir = new File(path);
			dir.mkdirs();
			
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			







			
			TipTmpFileDto tmpFileDto = new TipTmpFileDto();
			tmpFileDto.setSave_name(mRequest.getFilesystemName("f"));
			tmpFileDto.setUpload_name(mRequest.getOriginalFileName("f"));
			File target = mRequest.getFile("f");
			tmpFileDto.setFile_size(target.length());
			tmpFileDto.setFile_type(mRequest.getContentType("f"));
			
			TipTmpFileDao tmpFileDao = new TipTmpFileDao();
			int file_no = tmpFileDao.getSequence();
			tmpFileDto.setFile_no(file_no);
			tmpFileDao.writeWithPrimaryKey(tmpFileDto);
			
			String imgUrl = req.getContextPath() + "/tip_tmp_file/download.do?file_no=" + file_no;


			

			String json = "{ "

					+ "\"file_no\": \"" + file_no + "\"" + ","
					+ "\"imgUrl\": \"" + imgUrl + "\""
					+ "}";
			
			resp.setContentType("application/json");
			resp.getWriter().write(json);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}






