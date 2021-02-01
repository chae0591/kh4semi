package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;
import beans.QnaOpinionDao;
import beans.QnaOpinionDto;

@WebServlet(urlPatterns = "/qna_board/opinion_edit.do")
public class QnaOpinionEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 글번호(board_no), 글내용(board_content)
			req.setCharacterEncoding("UTF-8");
			QnaOpinionDto dto = new QnaOpinionDto();
			dto.setOpinion_no(Integer.parseInt(req.getParameter("opinion_no")));
			dto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			dto.setOpinion_content(req.getParameter("opinion_content"));
			
			//계산 : 수정
			QnaOpinionDao dao = new QnaOpinionDao();
			dao.update(dto);
			
			//출력 : detail.jsp(상세페이지)로 이동
			resp.sendRedirect("detail.jsp?board_no="+dto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
