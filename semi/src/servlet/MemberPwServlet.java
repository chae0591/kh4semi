package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;


@WebServlet(urlPatterns = "/member/pw.do")
public class MemberPwServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int member_no = (int)req.getSession().getAttribute("check");
			String member_pw = req.getParameter("member_pw");
			String change_pw = req.getParameter("change_pw");
			
			//처리 
			MemberDao dao = new MemberDao();
			boolean result = dao.editPassword(member_no, member_pw, change_pw);
			
			//출력
			if(result) {
				resp.sendRedirect("my.jsp");
			}
			else {
				resp.sendRedirect("pw.jsp?error");
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
