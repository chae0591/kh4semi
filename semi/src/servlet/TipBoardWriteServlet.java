package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.*;


@WebServlet(urlPatterns = "/tip_board/write.do")
public class TipBoardWriteServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
		

//		준비 : board_header, board_title, board_content, board_writer
//		= 3개는 파라미터(board_header, board_title, board_content)에서 가져올 수 있다.
//		= 1개는 세션의 정보를 이용하여 구해야 한다(member_no -> board_writer)
		req.setCharacterEncoding("UTF-8");
		
		TipBoardDto boardDto = new TipBoardDto();
		
		boardDto.setBoard_title(req.getParameter("board_title"));
		boardDto.setBoard_content(req.getParameter("board_content"));
		
//	    String str="2015-03-31";  
//	    Date date=new java.sql.Date.valueOf(req.getParameter("start_date"))(System.currentTimeMillis());//converting string into sql date  
//		boardDto.setStart_date(date);
//		boardDto.setEnd_date(date);
		
		boardDto.setStart_date(Date.valueOf(req.getParameter("start_date")));
		boardDto.setEnd_date(Date.valueOf(req.getParameter("end_date")));
		
		
		
//		현재 로그인한 사용자 정보를 불러오는 코드
		int member_no = (int)req.getSession().getAttribute("check");
		MemberDao memberDao = new MemberDao();
		MemberDto memberDto = memberDao.find(member_no);
		
//		memberDto의 member_id를 boardDto의 board_writer에 설정
		boardDto.setBoard_writer(memberDto.getMember_id());
		
//		처리 : BoardDao를 사용
//		1. 시퀀스 번호 생성 - .getSequence()
//		2. 등록 - .writeWithPrimaryKey()
		TipBoardDao boardDao = new TipBoardDao();
		int board_no = boardDao.getSequence();	//시퀀스번호생성
		boardDto.setBoard_no(board_no);			//생성된 번호를 DTO에 설정
		
		boardDao.writeWithPrimaryKey(boardDto);	//설정된 정보를 등록!
		
//		출력
		resp.sendRedirect("detail.jsp?board_no="+board_no);
		
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}






