package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;
import beans.QnaBoardDao;

@WebServlet(urlPatterns = "/qna_board/delete.do")
public class QnaBoardDeleteServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : board_no 필요
			int board_no = Integer.parseInt(req.getParameter("board_no"));
			
			//처리 : 삭제
			QnaBoardDao dao = new QnaBoardDao();
			dao.delete(board_no);
			
			//출력 : 목록으로 이동
			resp.sendRedirect("list.jsp");
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}