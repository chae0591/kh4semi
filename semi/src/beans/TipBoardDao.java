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


	public void plusVote(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update tip_board set vote=vote+1 where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.execute();

		con.close();
	}

	public void minusVote(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update tip_board set vote=vote-1 where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.execute();

		con.close();
	}
	

	public boolean delete(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete tip_board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
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
	

	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select tip_board_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);

		
		con.close();
		return seq;
	}
	

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


	public int getCount(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from tip_board where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		
		return count;
	}
	

	public int getCount() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from tip_board";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		
		return count;
	}
	
	
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
								+ "M.member_nick, " 
								+ "count(R.opinion_no) opinion_count "
							+ "from "
							+ "tip_board B "
							+ "inner join member M on B.board_writer = M.member_id "
							+ "left outer join tip_opinion R on B.board_no = R.board_no "
							+ "group by "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date, "
								+ "M.member_nick "
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
			vo.setMember_nick(rs.getString("member_nick"));
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
								+ "M.member_nick, " 
								+ "count(R.opinion_no) opinion_count "
							+ "from "
							+ "tip_board B "
							+ "inner join member M on B.board_writer = M.member_id "
							+ "left outer join tip_opinion R on B.board_no = R.board_no "
							+ "where instr(#1, ?) > 0 "
							+ "group by "
								+ "B.board_no, B.board_writer, B.board_title, B.board_content, "
								+ "B.regist_time, B.vote, "
								+ "B.start_date, B.end_date, "
								+ "M.member_nick "
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
			vo.setMember_nick(rs.getString("member_nick"));
			list.add(vo);
		}
		
		con.close();
		
		return list;
	}
	

	
	public TipBoardDto find(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from tip_board where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs = ps.executeQuery();
		
		
		
		TipBoardDto dto;
		if(rs.next()) {
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
		else {
			dto = null;
		}
		
		con.close();
		
		return dto;
	}
	
	
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
}
