package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;

public class TipVoteDao {

	public static final String USERNAME = "project5";
	public static final String PASSWORD = "project5";
	
	public void insert(TipVoteDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into tip_vote("
						+ "vote_no, board_no, member_no"
					+ ") "
					+ "values(tip_vote_seq.nextval, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getBoard_no());
		ps.setInt(2, dto.getMember_no());
		ps.execute();
		
		con.close();
	}

//	좋아요 취소 기능
	public void delete(TipVoteDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete tip_vote where board_no=? and member_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getBoard_no());
		ps.setInt(2, dto.getMember_no());
		ps.execute();
//		int count = ps.executeUpdate();
		
		con.close();
	}
	
	public boolean getIsVoted(TipVoteDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from tip_vote where board_no=? and member_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getBoard_no());
		ps.setInt(2, dto.getMember_no());
		ResultSet rs = ps.executeQuery();
		boolean isVoted = rs.next();
		con.close();
		return isVoted;
	}
	
	
////	댓글 수정
//	public void update(TipOpinionDto opinionDto) throws Exception {
//		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
//		
//		String sql = "update tip_opinion set opinion_text = ? where opinion_no = ?";
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setString(1, opinionDto.getOpinion_text());
//		ps.setInt(2, opinionDto.getOpinion_no());
//		ps.execute();
////		int count = ps.executeUpdate();
//		
//		con.close();
//	}
	
}





