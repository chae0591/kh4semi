package servlet;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;

@WebServlet(urlPatterns="/member/findpw.do")
public class MemberFindpwServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//수신 
			req.setCharacterEncoding("UTF-8");
			MemberDto dto = new MemberDto(); 
			dto.setMember_id(req.getParameter("member_id"));
			dto.setMember_nick(req.getParameter("member_nick"));
			
			
			
			MemberDao dao = new MemberDao(); 
			boolean result = dao.findpw(dto);
			
			
			if(result) {
				MemberDto a = dao.find(dto.getMember_id());
				req.getSession().setAttribute("check", a.getMember_no());
				req.getSession().setAttribute("pw", a.getMember_pw());
				resp.sendRedirect("findpwAfter.jsp");
			}
			else {
				resp.sendRedirect("findpw.jsp?error");
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
