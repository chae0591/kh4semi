package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.TipOpinionDao;
import beans.TipOpinionDto;


@WebServlet(urlPatterns = "/tip_board/opinion_edit.do")
public class TipOpinionEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			TipOpinionDto tipOpinionDto = new TipOpinionDto();
			tipOpinionDto.setOpinion_no(Integer.parseInt(req.getParameter("opinion_no")));
			tipOpinionDto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			tipOpinionDto.setOpinion_text(req.getParameter("opinion_text"));
			

			TipOpinionDao tipOpinionDao = new TipOpinionDao();
			tipOpinionDao.update(tipOpinionDto);
			

			resp.sendRedirect("detail.jsp?board_no="+tipOpinionDto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}





