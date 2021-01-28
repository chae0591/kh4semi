package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;

@WebServlet(urlPatterns = "/member/edit.do")
public class MemberNickeditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//ready 
			MemberDto dto = new MemberDto();
			dto.setMember_no((int)req.getSession().getAttribute("check"));
			dto.setMember_nick(req.getParameter("member_nick"));
			dto.setMember_pw(req.getParameter("member_pw"));
			
			//처리 
			MemberDao dao = new MemberDao();
			boolean result = dao.editnick(dto);
			
			//출력 
			if(result) {
				resp.sendRedirect("my.jsp");
			}
			else {
				resp.sendRedirect("nickedit.jsp?error");
			}
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
