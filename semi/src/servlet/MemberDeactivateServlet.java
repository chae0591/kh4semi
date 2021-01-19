package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;

@WebServlet(urlPatterns = "/member/delete.do")
public class MemberDeactivateServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int member_no = (int) req.getSession().getAttribute("check");
			
			MemberDao dao = new MemberDao();
			dao.delete(member_no);
			
	//			세션 만료
			req.getSession().invalidate();
			
			resp.sendRedirect("deactivate.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	
	}
	
}
