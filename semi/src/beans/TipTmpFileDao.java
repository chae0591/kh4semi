package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JdbcUtil;

public class TipTmpFileDao {
	
	public static final String USERNAME = "project5";
	public static final String PASSWORD = "project5";

	
	public boolean updateBoardNo(int file_no, int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update tip_tmp_file "
						+ "set board_no=?"
						+ "where file_no=? and board_no is NULL";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.setInt(2, file_no);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	

	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select tip_tmp_file_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);

		
		con.close();
		return seq;
	}
	

	public void writeWithPrimaryKey(TipTmpFileDto tmpFileDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into tip_tmp_file values(?, ?, ?, ?, ?, NULL)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, tmpFileDto.getFile_no());
		ps.setString(2, tmpFileDto.getUpload_name());
		ps.setString(3, tmpFileDto.getSave_name());
		ps.setLong(4, tmpFileDto.getFile_size());
		ps.setString(5, tmpFileDto.getFile_type());
		ps.execute();
		
		con.close();
		
	}
	

	public void insert(TipTmpFileDto tmpFileDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into tip_tmp_file values(tmp_file_seq.nextval, ?, ?, ?, ?, NULL)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, tmpFileDto.getUpload_name());
		ps.setString(2, tmpFileDto.getSave_name());
		ps.setLong(3, tmpFileDto.getFile_size());
		ps.setString(4, tmpFileDto.getFile_type());
		ps.execute();
		
		con.close();
	}
	

	public TipTmpFileDto find(int file_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from tip_tmp_file where file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ResultSet rs = ps.executeQuery();
		
		TipTmpFileDto tmpFileDto;
		if(rs.next()) {
			tmpFileDto = new TipTmpFileDto();
			tmpFileDto.setFile_no(rs.getInt("file_no"));
			tmpFileDto.setUpload_name(rs.getString("upload_name"));
			tmpFileDto.setSave_name(rs.getString("save_name"));
			tmpFileDto.setFile_size(rs.getLong("file_size"));
			tmpFileDto.setFile_type(rs.getString("file_type"));
		}
		else {
			tmpFileDto = null;
		}
		con.close();
		return tmpFileDto;
	}
	
}














