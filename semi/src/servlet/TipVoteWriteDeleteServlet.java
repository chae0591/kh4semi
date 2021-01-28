package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;
import beans.TipBoardDao;
import beans.TipVoteDao;
import beans.TipVoteDto;

@WebServlet(urlPatterns = "/tip_board/vote_insert_delete.do")
public class TipVoteWriteDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			
			TipVoteDto tipVoteDto = new TipVoteDto();
			tipVoteDto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));

			int member_no = (int)req.getSession().getAttribute("check");



			tipVoteDto.setMember_no(member_no);
			
			TipBoardDao tipBoardDao = new TipBoardDao();

			TipVoteDao tipVoteDao = new TipVoteDao();
			
			boolean isVoted = tipVoteDao.getIsVoted(tipVoteDto);
			if(!isVoted) {
				tipVoteDao.insert(tipVoteDto);
				tipBoardDao.plusVote(tipVoteDto.getBoard_no());
			}else {
				tipVoteDao.delete(tipVoteDto);
				tipBoardDao.minusVote(tipVoteDto.getBoard_no());
			}
			 

			resp.sendRedirect("detail.jsp?board_no="+tipVoteDto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}




