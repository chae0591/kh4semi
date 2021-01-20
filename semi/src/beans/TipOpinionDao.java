package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;

public class TipOpinionDao {

	public static final String USERNAME = "project5";
	public static final String PASSWORD = "project5";
	
	public void insert(TipOpinionDto opinionDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into tip_opinion("
						+ "opinion_no, opinion_text, board_no, opinion_writer"
					+ ") "
					+ "values(tip_opinion_seq.nextval, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, opinionDto.getOpinion_text());
		ps.setInt(2, opinionDto.getBoard_no());
		ps.setString(3, opinionDto.getOpinion_writer());
		ps.execute();
		
		con.close();
	}
	
	public List<TipOpinionDto> select(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from tip_opinion where board_no=? order by opinion_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs = ps.executeQuery();
		
		List<TipOpinionDto> list = new ArrayList<>();
		while(rs.next()) {
			TipOpinionDto opinionDto = new TipOpinionDto();
			opinionDto.setOpinion_no(rs.getInt("opinion_no"));
			opinionDto.setOpinion_text(rs.getString("opinion_text"));
			opinionDto.setRegist_time(rs.getDate("regist_time"));
			opinionDto.setBoard_no(rs.getInt("board_no"));
			opinionDto.setOpinion_writer(rs.getString("opinion_writer"));
			list.add(opinionDto);
		}
		con.close();
		return list;
	}
	
//	댓글 삭제 기능
	public void delete(int opinion_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete tip_opinion where opinion_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, opinion_no);
		ps.execute();
//		int count = ps.executeUpdate();
		
		con.close();
	}
	
//	댓글 수정
	public void update(TipOpinionDto opinionDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update tip_opinion set opinion_text = ? where opinion_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, opinionDto.getOpinion_text());
		ps.setInt(2, opinionDto.getOpinion_no());
		ps.execute();
//		int count = ps.executeUpdate();
		
		con.close();
	}
	
}





