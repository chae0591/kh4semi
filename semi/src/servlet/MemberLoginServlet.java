package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;

@WebServlet(urlPatterns="/member/login.do")
public class MemberLoginServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//수신 
			req.setCharacterEncoding("UTF-8");
			MemberDto dto = new MemberDto(); 
			dto.setMember_id(req.getParameter("member_id"));
			dto.setMember_pw(req.getParameter("member_pw"));
			
			//데이터 베이스 조회 구문 
			MemberDao dao = new MemberDao();
			boolean login = dao.login(dto);
			
			if(login) {
				MemberDto no = dao.find(dto.getMember_id()); // 회원번호로 세션 불러오기 check == member_no
				req.getSession().setAttribute("check", no.getMember_no());
				req.getSession().setAttribute("nick", no.getMember_nick());
				resp.sendRedirect(req.getContextPath()+"/index.jsp");
			}
			else {
				resp.sendRedirect("login.jsp?error");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
