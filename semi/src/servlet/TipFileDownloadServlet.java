package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.TipTmpFileDao;
import beans.TipTmpFileDto;


@WebServlet(urlPatterns = "/tip_tmp_file/download.do")
public class TipFileDownloadServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int file_no = Integer.parseInt(req.getParameter("file_no"));
			


			TipTmpFileDao tmpFileDao = new TipTmpFileDao();
			TipTmpFileDto tmpFileDto = tmpFileDao.find(file_no);
			
			String path = "D:/upload/kh45";
			File target = new File(path, tmpFileDto.getSave_name());
			byte[] data = new byte[(int)target.length()];
			FileInputStream in = new FileInputStream(target);
			in.read(data);
			in.close();
			


			
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(tmpFileDto.getFile_size()));
			resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(tmpFileDto.getUpload_name(), "UTF-8")+"\"");
			
			resp.getOutputStream().write(data);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}







