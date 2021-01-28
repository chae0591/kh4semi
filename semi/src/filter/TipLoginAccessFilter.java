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
	"/tip_board/write.jsp", 
	"/tip_board/edit.jsp",
	"/tip_board/delete.do",
	
	"/tip_board/opinion_insert.do",
	"/tip_board/opinion_edit.do",
	"/tip_board/opinion_delete.do",
	
	"/tip_board/vote_insert_delete.do",
	
	"/tip_tmp_file/receive.do"
})


public class TipLoginAccessFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		req.setCharacterEncoding("UTF-8");
		HttpServletResponse resp = (HttpServletResponse)response;
		
//		try {
//			String auth = (String)req.getSession().getAttribute("auth");
//			if(auth != null && auth.equals("관리자")) {
//				chain.doFilter(request, response);
//				return;
//			}
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//			resp.sendError(500);
//		}

		try {
			int check = (int) req.getSession().getAttribute("check");
			chain.doFilter(request, response);
			return;
		}catch(Exception e) {
			e.printStackTrace();
			//error page - redirect login page
			resp.sendError(403);
		}
	}
}
