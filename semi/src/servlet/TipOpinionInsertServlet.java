package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;
import beans.TipOpinionDao;
import beans.TipOpinionDto;

@WebServlet(urlPatterns = "/tip_board/opinion_insert.do")
public class TipOpinionInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			
			TipOpinionDto tipOpinionDto = new TipOpinionDto();
			tipOpinionDto.setOpinion_text(req.getParameter("opinion_text"));
			tipOpinionDto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			
			int member_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(member_no);
			
			tipOpinionDto.setOpinion_writer(memberDto.getMember_id());
			

			TipOpinionDao tipOpinionDao = new TipOpinionDao();
			tipOpinionDao.insert(tipOpinionDto);
			 

			resp.sendRedirect("detail.jsp?board_no="+tipOpinionDto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}




