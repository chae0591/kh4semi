package beans;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;

public class TipBoardDao {
	
	public static final String USERNAME = "project5";
	public static final String PASSWORD = "project5";
	
	public void write(TipBoardDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into tip_board("
				+ "board_no, "
				+ "board_writer, "
				+ "board_title, board_content, "
				+ "start_date, end_date) "
				+ "values( "
				+ "tip_board_seq.nextval, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "? "
				+ ");";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getBoard_writer());
		ps.setString(2, dto.getBoard_title());
		ps.setString(3, dto.getBoard_content());
		ps.setDate(4, dto.getStart_date());
		ps.setDate(5, dto.getEnd_date());
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
	
	
}














