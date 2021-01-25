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
			QnaOpinionDto dto = new QnaOpinionDto();
			dto.setOpinion_content(req.getParameter("opinion_content"));
			dto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			
			int memeber_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(memeber_no);
			
			dto.setOpinion_writer(memberDto.getMember_id());
			
			//계산 : 댓글 테이블에 등록
			QnaOpinionDao dao = new QnaOpinionDao();
			dao.insert(dto);
			
			//츨력 : detail.jsp(상세페이지)로 이동
			resp.sendRedirect("detail.jsp?board_no="+dto.getBoard_no());
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
