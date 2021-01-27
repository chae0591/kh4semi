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
import beans.MemberDao;
import beans.MemberDto;


@WebFilter(urlPatterns = {
	"/tip_board/edit.jsp", "/tip_board/edit.do",
	"/tip_board/delete.do"
})


public class TipBoardAccessFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		req.setCharacterEncoding("UTF-8");
		HttpServletResponse resp = (HttpServletResponse)response;
		
		try {



			

			String auth = (String)req.getSession().getAttribute("auth");
			if(auth != null && auth.equals("관리자")) {
				chain.doFilter(request, response);
				return;
			}
			

			int board_no = Integer.parseInt(req.getParameter("board_no"));
			TipBoardDao boardDao = new TipBoardDao();
			TipBoardDto boardDto = boardDao.find(board_no);
			
			int member_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(member_no);
			
			if(memberDto.getMember_id().equals(boardDto.getBoard_writer())) {
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
