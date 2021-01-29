package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.QnaBoardDao;
import beans.QnaOpinionDao;
import beans.QnaOpinionDto;

@WebServlet(urlPatterns = "/qna_board/opinion_delete.do")
public class QnaOpinionDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : opinion_no, board_no
			QnaOpinionDto opinionDto = new QnaOpinionDto();
			opinionDto.setOpinion_no(Integer.parseInt(req.getParameter("opinion_no")));
			opinionDto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			//int opinion_no = Integer.parseInt(req.getParameter("opinion_no"));
			//int board_no = Integer.parseInt(req.getParameter("board_no"));
			
			//계산 : 삭제
			QnaOpinionDao opinionDao = new QnaOpinionDao();
			QnaBoardDao boardDao = new QnaBoardDao();
			
			boolean isCounted = opinionDao.getIsCounted(opinionDto);
			
			if(isCounted) {
				opinionDao.delete(opinionDto);
				boardDao.minusOpinion(opinionDto.getBoard_no());
			}
			
			//출력 : detail.jsp(상세페이지)로 이동
			resp.sendRedirect("detail.jsp?board_no="+opinionDto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
