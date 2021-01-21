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
 *	댓글 삭제 서블릿
 *	= 필요한 정보 : 삭제를 위한 댓글번호(reply_no), 되돌아가기 위한 글번호(board_no) 
 */
@WebServlet(urlPatterns = "/tip_board/opinion_delete.do")
public class TipOpinionDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비 : reply_no, board_no
			int opinion_no = Integer.parseInt(req.getParameter("opinion_no"));
			int board_no = Integer.parseInt(req.getParameter("board_no"));
			
//			계산 : 삭제
			TipOpinionDao tipOpinionDao = new TipOpinionDao();
			tipOpinionDao.delete(opinion_no);
			
//			출력 : detail.jsp로 리다이렉트
			resp.sendRedirect("detail.jsp?board_no="+board_no);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}



