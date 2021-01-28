package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.TipBoardDao;
import beans.TipBoardDto;
import beans.TipOpinionDao;
import beans.TipOpinionDto;
import beans.MemberDao;
import beans.MemberDto;


@WebFilter(urlPatterns = {
	"/tip_board/opinion_edit.do",
	"/tip_board/opinion_delete.do"
})


public class TipOpinionNoAccessFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		req.setCharacterEncoding("UTF-8");
		HttpServletResponse resp = (HttpServletResponse)response;
		
		try {

//			String auth = (String)req.getSession().getAttribute("auth");
//			if(auth != null && auth.equals("관리자")) {
//				chain.doFilter(request, response);
//				return;
//			}

			int opinion_no = Integer.parseInt(req.getParameter("opinion_no"));
			TipOpinionDao opinionDao = new TipOpinionDao();
			TipOpinionDto opinionDto = opinionDao.find(opinion_no);
			
			int member_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(member_no);
			
			if(memberDto.getMember_id().equals(opinionDto.getOpinion_writer())) {
				chain.doFilter(request, response);
				return;
			}

			resp.sendError(403);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
