package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.TipOpinionDao;
import beans.TipOpinionDto;

/**
 * 댓글 수정 서블릿
 */
@WebServlet(urlPatterns = "/tip_board/opinion_edit.do")
public class TipOpinionEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비 : 글번호(reply_origin) , 글내용(reply_content)
			req.setCharacterEncoding("UTF-8");
			TipOpinionDto tipOpinionDto = new TipOpinionDto();
			tipOpinionDto.setOpinion_no(Integer.parseInt(req.getParameter("opinion_no")));
			tipOpinionDto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			tipOpinionDto.setOpinion_text(req.getParameter("opinion_text"));
			
//			계산 : 수정
			TipOpinionDao tipOpinionDao = new TipOpinionDao();
			tipOpinionDao.update(tipOpinionDto);
			
//			출력 : detail.jsp로 복귀
			resp.sendRedirect("detail.jsp?board_no="+tipOpinionDto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}





