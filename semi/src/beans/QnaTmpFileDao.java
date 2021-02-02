package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JdbcUtil;

public class QnaTmpFileDao {
	public static final String USERNAME = "kh45";
	public static final String PASSWORD = "kh45";

	//수정 기능
	public boolean updateBoardNo(int file_no, int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update qna_tmp_file "
						+ "set board_no=?"
						+ "where file_no=? and board_no is NULL";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.setInt(2, file_no);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
//	시퀀스 번호를 미리 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select qna_tmp_file_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();//무조건 나옴
		int seq = rs.getInt(1);
//		int seq = rs.getInt("NEXTVAL");
		
		con.close();
		return seq;
	}
	
//	번호까지 함께 등록하는 기능
	public void writeWithPrimaryKey(QnaTmpFileDto qnaFileDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into qna_tmp_file values(?, ?, ?, ?, ?, NULL)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaFileDto.getFile_no());
		ps.setString(2, qnaFileDto.getUpload_name());
		ps.setString(3, qnaFileDto.getSave_name());
		ps.setLong(4, qnaFileDto.getFile_size());
		ps.setString(5, qnaFileDto.getFile_type());
		ps.execute();
		
		con.close();
		
	}
	
//	등록 기능
	public void insert(QnaTmpFileDto qnaFileDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into qna_tmp_file values(qna_file_seq.nextval, ?, ?, ?, ?, NULL)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, qnaFileDto.getUpload_name());
		ps.setString(2, qnaFileDto.getSave_name());
		ps.setLong(3, qnaFileDto.getFile_size());
		ps.setString(4, qnaFileDto.getFile_type());
		ps.execute();
		
		con.close();
	}
	
//	단일 조회 기능
	public QnaTmpFileDto find(int file_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from qna_tmp_file where file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ResultSet rs = ps.executeQuery();//데이터 개수 : 없거나 한 개 있거나
		
		QnaTmpFileDto qnaFileDto;
		if(rs.next()) {
			qnaFileDto = new QnaTmpFileDto();
			qnaFileDto.setFile_no(rs.getInt("file_no"));
			qnaFileDto.setUpload_name(rs.getString("upload_name"));
			qnaFileDto.setSave_name(rs.getString("save_name"));
			qnaFileDto.setFile_size(rs.getLong("file_size"));
			qnaFileDto.setFile_type(rs.getString("file_type"));
		}
		else {
			qnaFileDto = null;
		}
		con.close();
		return qnaFileDto;
	}
	
}
