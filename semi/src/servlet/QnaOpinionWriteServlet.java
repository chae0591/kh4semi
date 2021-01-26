package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;
import beans.QnaOpinionDao;
import beans.QnaOpinionDto;

@WebServlet(urlPatterns = "/qna_board/opinion_write.do")
public class QnaOpinionWriteServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 파라미터(내용, 원본글번호) + 세션(사용자정보)
			req.setCharacterEncoding("UTF-8");
			QnaOpinionDto opinionDto = new QnaOpinionDto();
			opinionDto.setOpinion_content(req.getParameter("opinion_content"));
			opinionDto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			
			//현재 로그인한 사용자 정보를 불러오는 코드
			int memeber_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(memeber_no);
			
			//MemberDto의 member_id를 QnaOpinionDto의 opinion_writer에 설정
			opinionDto.setOpinion_writer(memberDto.getMember_id());
			
			//처리 : QnaOpinipnDao를 사용, 댓글 테이블에 등록
			//1. 시퀀스 번호 생성 = .getSequence()
			//2. 등록 = .writeWithPrimaryKey()
			QnaOpinionDao opinionDao = new QnaOpinionDao();
			int opinion_no = opinionDao.getSequence(); 	//시퀀스번호생성
			opinionDto.setOpinion_no(opinion_no); 		//생성된 번호를 DTO에 설정
			opinionDao.writeWithPrimaryKey(opinionDto); //설정된 정보를 등록!
			 			
			//츨력 : detail.jsp(상세페이지)로 이동
			resp.sendRedirect("detail.jsp?board_no="+opinionDto.getBoard_no());
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
