package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JdbcUtil;

public class QnaVoteDao {

	public static final String USERNAME = "project5";
	public static final String PASSWORD = "project5";
	
	//좋아요 기능
	public void insert(QnaVoteDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into qna_vote("
						+ "vote_no, board_no, member_no"
					+ ") "
					+ "values(qna_vote_seq.nextval, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getBoard_no());
		ps.setInt(2, dto.getMember_no());
		ps.execute();
		
		con.close();
	}

	//좋아요 취소 기능
	public void delete(QnaVoteDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete qna_vote where board_no=? and member_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getBoard_no());
		ps.setInt(2, dto.getMember_no());
		ps.execute();
		
		con.close();
	}
	
	public boolean getIsVoted(QnaVoteDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from qna_vote where board_no=? and member_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getBoard_no());
		ps.setInt(2, dto.getMember_no());
		ResultSet rs = ps.executeQuery();
		boolean isVoted = rs.next();
		con.close();
		return isVoted;
	}
}
