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
//			준비 : 파라미터(내용,원본글번호) + 세션(사용자정보)
			req.setCharacterEncoding("UTF-8");
			
			TipOpinionDto tipOpinionDto = new TipOpinionDto();
			tipOpinionDto.setOpinion_text(req.getParameter("opinion_text"));
			tipOpinionDto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			
			String member_nick = (String)req.getSession().getAttribute("nick");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(member_nick);
			
			tipOpinionDto.setOpinion_writer(memberDto.getMember_id());
			
//			계산 : 댓글 테이블에 등록
			TipOpinionDao tipOpinionDao = new TipOpinionDao();
			tipOpinionDao.insert(tipOpinionDto);
			 
//			출력 : 상세보기 글로 다시 돌아가도록 처리
			resp.sendRedirect("detail.jsp?board_no="+tipOpinionDto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}




