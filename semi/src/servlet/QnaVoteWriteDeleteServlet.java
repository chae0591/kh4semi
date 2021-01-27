package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;
import beans.QnaBoardDao;
import beans.QnaVoteDao;
import beans.QnaVoteDto;

@WebServlet(urlPatterns = "/qna_board/vote_write_delete.do")
public class QnaVoteWriteDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			
			QnaVoteDto qnavoteDto = new QnaVoteDto();
			qnavoteDto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			
			//현재 로그인한 사용자 정보를 불러오는 코드
			int member_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(member_no);
			
			//memberDto의 member_id를 qnavoteDto의 member_no에 설정
			qnavoteDto.setMember_no(member_no);
			
			//계산
			QnaVoteDao qnavoteDao = new QnaVoteDao();
			QnaBoardDao qnaboardDao = new QnaBoardDao();
			
			boolean isVoted = qnavoteDao.getIsVoted(qnavoteDto);
			if(!isVoted) {
				//vote에 추가
				qnavoteDao.insert(qnavoteDto);
				//board에 추가
				qnaboardDao.plusVote(qnavoteDto.getBoard_no());
			}else {
				//vote에 추가
				qnavoteDao.delete(qnavoteDto);
				//board에 추가
				qnaboardDao.minusVote(qnavoteDto.getBoard_no());
			}
			
			//출력 : 상세페이지로 이동
			resp.sendRedirect("detail.jsp?board_no="+qnavoteDto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
