package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;

public class TipBoardDao {
	
	public static final String USERNAME = "project5";
	public static final String PASSWORD = "project5";

//	조회수 증가 기능 : 성공/실패를 반환할 필요가 없음
	public void plusVote(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update tip_board set vote=vote+1 where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.execute();
//		int count = ps.executeUpdate();
		con.close();
	}
//	조회수 증가 기능 : 성공/실패를 반환할 필요가 없음
	public void minusVote(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update tip_board set vote=vote-1 where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.execute();
//		int count = ps.executeUpdate();
		con.close();
	}
	
//	삭제 기능
	public boolean delete(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete tip_board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	//수정 기능
	public boolean update(TipBoardDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update tip_board "
						+ "set board_title=?, board_content=?,"
						+ "start_date=?, end_date=? "
						+ "where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getBoard_title());
		ps.setString(2, dto.getBoard_content());
		ps.setDate(3, dto.getStart_date());
		ps.setDate(4, dto.getEnd_date());
		ps.setInt(5, dto.getBoard_no());
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
//		if(count > 0) {
//			return true;
//		}
//		else {
//			return false;
//		}
	}
	
	public void write(TipBoardDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into tip_board("
				+ "board_no, "
				+ "board_writer, "
				+ "board_title, board_content, "
				+ "start_date, end_date) "
				+ "values( "
				+ "tip_board_seq.nextval, "
				+ "?, ?, ?, ?, ? "
				+ ")";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getBoard_writer());
		ps.setString(2, dto.getBoard_title());
		ps.setString(3, dto.getBoard_content());
		ps.setDate(4, dto.getStart_date());
		ps.setDate(5, dto.getEnd_date());
		ps.execute();
		con.close();
	}
	
//	시퀀스 번호를 미리 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select tip_board_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();//무조건 나옴
		int seq = rs.getInt(1);
//		int seq = rs.getInt("NEXTVAL");
		
		con.close();
		return seq;
	}
	
//	번호까지 함께 등록하는 기능
	public void writeWithPrimaryKey(TipBoardDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "insert into tip_board("
				+ "board_no, "
				+ "board_writer, "
				+ "board_title, board_content, "
				+ "start_date, end_date) "
				+ "values( "
				+ "?, ?, ?, ?, ?, ? "
				+ ")";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getBoard_no());
		ps.setString(2, dto.getBoard_writer());
		ps.setString(3, dto.getBoard_title());
		ps.setString(4, dto.getBoard_content());
		ps.setDate(5, dto.getStart_date());
		ps.setDate(6, dto.getEnd_date());
		ps.execute();
		con.close();
		
	}
	
	
	public List<TipBoardDto> select() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from tip_board order by board_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<TipBoardDto> list = new ArrayList<>();
		while(rs.next()) {
			TipBoardDto dto = new TipBoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_writer(rs.getString("board_writer"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_content(rs.getString("board_content"));
			dto.setRegist_time(rs.getDate("regist_time"));
			dto.setVote(rs.getInt("vote"));
			dto.setStart_date(rs.getDate("start_date"));
			dto.setEnd_date(rs.getDate("end_date"));
			list.add(dto);
		}
		con.close();
		return list;
	}

//	검색 개수를 구하는 메소드
	public int getCount(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from tip_board where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
//		int count = rs.getInt("count(*)");
		con.close();
		
		return count;
	}
	
//	목록 개수를 구하는 메소드
	public int getCount() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from tip_board";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
//		int count = rs.getInt("count(*)");
		con.close();
		
		return count;
	}
	
	//검색 결과 DAO
	public List<TipSearchVO> select(String keyword) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
			String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
							+ "select * from("
								+ "select T.board_title, T.board_content, T.regist_time, T.start_date, T.end_date, T.board_no, M.member_nick from "
								+ "tip_board T inner join member M "
								+ "on M.member_id = T.board_writer "
								+ "where instr(board_title, ?) > 0 order by board_no desc)"
							+ ")TMP"
							+ ") where rn between 1 and 6";
					
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ResultSet rs = ps.executeQuery();
				
			List<TipSearchVO> list = new ArrayList<>();
			while(rs.next()) {
				TipSearchVO tipsearchVO = new TipSearchVO();
				tipsearchVO.setBoard_no(rs.getInt("board_no"));
				tipsearchVO.setBoard_title(rs.getString("board_title"));
				tipsearchVO.setBoard_content(rs.getString("board_content"));
				tipsearchVO.setRegist_time(rs.getDate("regist_time"));
				tipsearchVO.setMember_nick(rs.getString("member_nick"));
				tipsearchVO.setStart_date(rs.getDate("start_date"));
				tipsearchVO.setEnd_date(rs.getDate("end_date"));
				list.add(tipsearchVO);
			}
				
				con.close();
				
				return list;
			}
	
	
//	페이징 + 댓글개수까지 불러오는 목록 메소드
	public List<TipBoardOpinionCountVO> pagingReplyCountList(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from ("
						+ "select rownum rn, TMP.* from ("
							+ "select "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date, "
								+ "count(R.opinion_no) opinion_count "
							+ "from "
							+ "tip_board B left outer join tip_opinion R on B.board_no = R.board_no "
							+ "group by "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date "
							+ "order by B.board_no desc "
						+ ")TMP "
					+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<TipBoardOpinionCountVO> list = new ArrayList<>();
		while(rs.next()) {
			TipBoardOpinionCountVO vo = new TipBoardOpinionCountVO();
			vo.setBoard_no(rs.getInt("board_no"));
			vo.setBoard_writer(rs.getString("board_writer"));
			vo.setBoard_title(rs.getString("board_title"));
			vo.setBoard_content(rs.getString("board_content"));
			vo.setRegist_time(rs.getDate("regist_time"));
			vo.setVote(rs.getInt("vote"));
			vo.setStart_date(rs.getDate("start_date"));
			vo.setEnd_date(rs.getDate("end_date"));
			vo.setOpinion_count(rs.getInt("opinion_count"));
			list.add(vo);
		}
		
		con.close();
		
		return list;
	}
	
	public List<TipBoardOpinionCountVO> pagingReplyCountList(String type, String key, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "select * from ("
						+ "select rownum rn, TMP.* from ("
							+ "select "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date, "
								+ "count(R.opinion_no) opinion_count "
							+ "from "
							+ "tip_board B left outer join tip_opinion R on B.board_no = R.board_no "
							+ "where instr(#1, ?) > 0 "
							+ "group by "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date "
							+ "order by B.board_no desc "
						+ ")TMP "
					+ ") where rn between ? and ?";
		
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<TipBoardOpinionCountVO> list = new ArrayList<>();
		while(rs.next()) {
			TipBoardOpinionCountVO vo = new TipBoardOpinionCountVO();
			vo.setBoard_no(rs.getInt("board_no"));
			vo.setBoard_writer(rs.getString("board_writer"));
			vo.setBoard_title(rs.getString("board_title"));
			vo.setBoard_content(rs.getString("board_content"));
			vo.setRegist_time(rs.getDate("regist_time"));
			vo.setVote(rs.getInt("vote"));
			vo.setStart_date(rs.getDate("start_date"));
			vo.setEnd_date(rs.getDate("end_date"));
			vo.setOpinion_count(rs.getInt("opinion_count"));
			list.add(vo);
		}
		
		con.close();
		
		return list;
	}

	

//	페이징 + 댓글개수까지 불러오는 목록 메소드
	public List<TipBoardOpinionCountVO> orderedPagingReplyCountList(int orderColomn, int orderType, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String orderSql = "";
		switch (orderColomn) {
			case 1:
				orderSql += "count(R.opinion_no)";
				break;
			default:
				orderSql += "B.board_no";
				break;
		}
		switch (orderType) {
			case 1:
				orderSql += " asc ";
				break;
			default:
				orderSql += " desc ";
				break;
		}
		
		String sql = "select * from ("
						+ "select rownum rn, TMP.* from ("
							+ "select "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date, "
								+ "count(R.opinion_no) opinion_count "
							+ "from "
							+ "tip_board B left outer join tip_opinion R on B.board_no = R.board_no "
							+ "group by "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date "
							+ "order by #1 "
						+ ")TMP "
					+ ") where rn between ? and ?";
		sql = sql.replace("#1", orderSql);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<TipBoardOpinionCountVO> list = new ArrayList<>();
		while(rs.next()) {
			TipBoardOpinionCountVO vo = new TipBoardOpinionCountVO();
			vo.setBoard_no(rs.getInt("board_no"));
			vo.setBoard_writer(rs.getString("board_writer"));
			vo.setBoard_title(rs.getString("board_title"));
			vo.setBoard_content(rs.getString("board_content"));
			vo.setRegist_time(rs.getDate("regist_time"));
			vo.setVote(rs.getInt("vote"));
			vo.setStart_date(rs.getDate("start_date"));
			vo.setEnd_date(rs.getDate("end_date"));
			vo.setOpinion_count(rs.getInt("opinion_count"));
			list.add(vo);
		}
		
		con.close();
		
		return list;
	}
	
	public List<TipBoardOpinionCountVO> orderedPagingReplyCountList(int orderColomn, int orderType, String type, String key, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String orderSql = "";
		switch (orderColomn) {
			case 1:
				orderSql += "count(R.opinion_no)";
				break;
			default:
				orderSql += "B.board_no";
				break;
		}
		switch (orderType) {
			case 1:
				orderSql += " asc ";
				break;
			default:
				orderSql += " desc ";
				break;
		}
		String sql = "select * from ("
						+ "select rownum rn, TMP.* from ("
							+ "select "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date, "
								+ "count(R.opinion_no) opinion_count "
							+ "from "
							+ "tip_board B left outer join tip_opinion R on B.board_no = R.board_no "
							+ "where instr(#1, ?) > 0 "
							+ "group by "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date "
							+ "order by #2 "
						+ ")TMP "
					+ ") where rn between ? and ?";
		
		sql = sql.replace("#1", type);
		sql = sql.replace("#2", orderSql);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<TipBoardOpinionCountVO> list = new ArrayList<>();
		while(rs.next()) {
			TipBoardOpinionCountVO vo = new TipBoardOpinionCountVO();
			vo.setBoard_no(rs.getInt("board_no"));
			vo.setBoard_writer(rs.getString("board_writer"));
			vo.setBoard_title(rs.getString("board_title"));
			vo.setBoard_content(rs.getString("board_content"));
			vo.setRegist_time(rs.getDate("regist_time"));
			vo.setVote(rs.getInt("vote"));
			vo.setStart_date(rs.getDate("start_date"));
			vo.setEnd_date(rs.getDate("end_date"));
			vo.setOpinion_count(rs.getInt("opinion_count"));
			list.add(vo);
		}
		
		con.close();
		
		return list;
	}
	

	//상세보기(단일조회)
	public TipBoardDto find(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from tip_board where board_no = ?";//결과가 절대로 여러개가 나올 수 없다
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs = ps.executeQuery();
		
		//rs는 예상 결과가 1개 아니면 0개. 즉 있냐 없냐만 알면 된다.
		//목록처럼 List를 만들어서 add를 할 필요가 없다(while문이 필요 없다)
		TipBoardDto dto;
		if(rs.next()) {//결과가 있다면 객체를 만들어 데이터베이스 값을 전부다 복사하겠다
			dto = new TipBoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_writer(rs.getString("board_writer"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_content(rs.getString("board_content"));
			dto.setRegist_time(rs.getDate("regist_time"));
			dto.setVote(rs.getInt("vote"));
			dto.setStart_date(rs.getDate("start_date"));
			dto.setEnd_date(rs.getDate("end_date"));
		}
		else {//결과가 없다면 잘못된 번호니까 null이라는 값을 반환하겠다
			dto = null;
		}
		
		con.close();
		
		return dto;
	}
	
	//검색 결과 더보기 DAO
		public List<TipSearchVO> select1(String keyword) throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
					
				String sql = "select T.board_title, T.board_content, T.regist_time, T.start_date, T.end_date, T.board_no, M.member_nick from "
								+ "tip_board T inner join member M on "
								+ "M.member_id = T.board_writer "
								+ "where instr(board_title, ?) > 0 order by board_no desc";
						
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, keyword);
				ResultSet rs = ps.executeQuery();
					
				List<TipSearchVO> list = new ArrayList<>();
				while(rs.next()) {
					TipSearchVO tipsearchVO = new TipSearchVO();
					tipsearchVO.setBoard_no(rs.getInt("board_no"));
					tipsearchVO.setBoard_title(rs.getString("board_title"));
					tipsearchVO.setBoard_content(rs.getString("board_content"));
					tipsearchVO.setRegist_time(rs.getDate("regist_time"));
					tipsearchVO.setMember_nick(rs.getString("member_nick"));
					tipsearchVO.setStart_date(rs.getDate("start_date"));
					tipsearchVO.setEnd_date(rs.getDate("end_date"));
					list.add(tipsearchVO);
				}
					
					con.close();
					
					return list;
				}
	//메인 선택글(최신순 6개)	
	public List<TipSearchVO> selectMain() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
		String sql = "select * from ("
						+ "select rownum rn, TMP.* from ("
						+ "select * from("
							+ "select T.board_title, T.board_content, T.board_no, T.regist_time, T.start_date, T.end_date, M.member_nick from "
							+ "tip_board T inner join member M on M.member_id = T.board_writer "
							+ "order by board_no desc)"
							+ ")TMP"
							+ ") where rn between 1 and 6";
				
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
			
		List<TipSearchVO> list = new ArrayList<>();
		while(rs.next()) {
			TipSearchVO tipsearchVO = new TipSearchVO();
			tipsearchVO.setBoard_no(rs.getInt("board_no"));
			tipsearchVO.setBoard_title(rs.getString("board_title"));
			tipsearchVO.setBoard_content(rs.getString("board_content"));
			tipsearchVO.setRegist_time(rs.getDate("regist_time"));
			tipsearchVO.setStart_date(rs.getDate("start_date"));
			tipsearchVO.setEnd_date(rs.getDate("end_date"));
			tipsearchVO.setMember_nick(rs.getString("member_nick"));
			list.add(tipsearchVO);
		}
			
			con.close();
			
			return list;
		}
	
	//페이징을 이용한 검색
	public List<TipSearchVO> searchPagingList(String keyword, int startRow, int endRow) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from("
					+ "select T.board_title, T.board_content, T.regist_time, T.start_date, T.end_date, T.board_no, M.member_nick from "
					+ "tip_board T inner join member M "
					+ "on M.member_id = T.board_writer "
					+ "where instr(board_title, ?) > 0 order by board_no desc)"
				+ ")TMP"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<TipSearchVO> list = new ArrayList<>();
		while(rs.next()) {
			TipSearchVO tipsearchVO = new TipSearchVO();
			tipsearchVO.setBoard_no(rs.getInt("board_no"));
			tipsearchVO.setBoard_title(rs.getString("board_title"));
			tipsearchVO.setBoard_content(rs.getString("board_content"));
			tipsearchVO.setRegist_time(rs.getDate("regist_time"));
			tipsearchVO.setStart_date(rs.getDate("start_date"));
			tipsearchVO.setEnd_date(rs.getDate("end_date"));
			tipsearchVO.setMember_nick(rs.getString("member_nick"));
			list.add(tipsearchVO);
		}
			
			con.close();
			
			return list;
	}
}
