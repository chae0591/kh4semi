package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.*;

@WebServlet(urlPatterns = "/tip_board/edit.do")
public class TipBoardEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비 : 데이터 4개(번호,말머리,제목,내용)
			req.setCharacterEncoding("UTF-8");
			TipBoardDto boardDto = new TipBoardDto();
			int board_no = Integer.parseInt(req.getParameter("board_no"));
			boardDto.setBoard_no(board_no);
			boardDto.setBoard_title(req.getParameter("board_title"));
			boardDto.setBoard_content(req.getParameter("board_content"));

//		    String str="2015-03-31";  
//		    Date date=Date.valueOf(str);//converting string into sql date  
//			boardDto.setStart_date(date);
//			boardDto.setEnd_date(date);

			boardDto.setStart_date(Date.valueOf(req.getParameter("start_date")));
			boardDto.setEnd_date(Date.valueOf(req.getParameter("end_date")));
			
			
//			처리 : 수정
			TipBoardDao boardDao = new TipBoardDao();
			boardDao.update(boardDto);
			
			String s_file_no_list = req.getParameter("file_no_list");
			TipTmpFileDao tipTmpFileDao = new TipTmpFileDao();
			if(s_file_no_list != null && s_file_no_list.length() > 0) {
				String[] file_no_list = s_file_no_list.split(",");
				for (String s : file_no_list) {
					int file_no = Integer.parseInt(s);
					tipTmpFileDao.updateBoardNo(file_no, board_no);
				}
			}
			
//			출력 : 상세페이지로 이동
//			resp.sendRedirect("detail.jsp?board_no="+boardDto.getBoard_no());
			resp.sendRedirect(req.getContextPath()+"/tip_board/detail.jsp?board_no="+boardDto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
