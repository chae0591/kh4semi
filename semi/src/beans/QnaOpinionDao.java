package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.JdbcUtil;

public class QnaOpinionDao {

	public static final String USERNAME = "project5";
	public static final String PASSWORD = "project5";
	
	public void insert(QnaOpinionDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into qna_opinion("
				+ "opinion_no, opinion_text, regist_time, opinion_writer"
				+ ")"
				+ "values(qna_opinion_seq.nextval, ?, sysdate, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getOpinion_text());
		ps.setString(2, dto.getOpinion_writer());
		ps.execute();
		
		con.close();
	}
}
