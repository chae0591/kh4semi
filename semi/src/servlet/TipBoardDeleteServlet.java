package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.TipBoardDao;


@WebServlet(urlPatterns = "/tip_board/delete.do")
public class TipBoardDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int board_no = Integer.parseInt(req.getParameter("board_no"));
			

			TipBoardDao boardDao = new TipBoardDao();
			boardDao.delete(board_no);
			


			resp.sendRedirect(req.getContextPath()+"/tip_board/list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
