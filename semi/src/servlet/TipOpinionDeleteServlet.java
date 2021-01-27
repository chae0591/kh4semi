package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.TipOpinionDao;
import beans.TipOpinionDto;


@WebServlet(urlPatterns = "/tip_board/opinion_delete.do")
public class TipOpinionDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int opinion_no = Integer.parseInt(req.getParameter("opinion_no"));
			int board_no = Integer.parseInt(req.getParameter("board_no"));
			

			TipOpinionDao tipOpinionDao = new TipOpinionDao();
			tipOpinionDao.delete(opinion_no);
			

			resp.sendRedirect("detail.jsp?board_no="+board_no);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}



