package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.*;

@WebServlet(urlPatterns = "/qna_board/edit.do")
public class QnaBoardEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : board_no, board_title, board_content
			req.setCharacterEncoding("UTF-8");
			QnaBoardDto dto = new QnaBoardDto();
			dto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			dto.setBoard_title(req.getParameter("board_title"));
			dto.setBoard_content(req.getParameter("board_content"));
			
			//처리 : 수정
			QnaBoardDao dao = new QnaBoardDao();
			dao.update(dto);
			
			//출력 : 상세페이지로 이동
			resp.sendRedirect("detail.jsp?board_no="+dto.getBoard_no());
			
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}