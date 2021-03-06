package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;

public class QnaOpinionDao {

	public static final String USERNAME = "kh45";
	public static final String PASSWORD = "kh45";
	
	//댓글 등록 기능
	public void insert(QnaOpinionDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into qna_opinion("
				+"opinion_no, opinion_content, regist_time, board_no, opinion_writer"
				+ ")"
				+ "values(qna_opinion_seq.nextval, ?, sysdate, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getOpinion_content());
		ps.setInt(2, dto.getBoard_no());
		ps.setString(3, dto.getOpinion_writer());
		ps.execute();
		
		con.close();
	}
	

	//시퀀스 번호를 미리 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
 
		String sql = "select qna_opinion_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int seq = rs.getInt(1);
 
		con.close();
		return seq;
	}
	
	//번호까지 함께 등록하는 기능
	public void writeWithPrimaryKey(QnaOpinionDto opinionDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
	
		String sql = "insert into qna_opinion values(?, ?, sysdate, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, opinionDto.getOpinion_no());
		ps.setString(2, opinionDto.getOpinion_content());
		ps.setInt(3, opinionDto.getBoard_no());
		ps.setString(4, opinionDto.getOpinion_writer());
		ps.execute();
	
		con.close();
	}
	
	public boolean getIsCounted(QnaOpinionDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from qna_opinion where opinion_no=? and board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getOpinion_no());
		ps.setInt(2, dto.getBoard_no());
		ResultSet rs = ps.executeQuery();
		boolean isVoted = rs.next();
		con.close();
		return isVoted;
	}
	
	//댓글 리스트
	public List<QnaOpinionDto> select(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from qna_opinion where board_no=? order by opinion_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs = ps.executeQuery();
		
		List<QnaOpinionDto> list = new ArrayList<>();
		while(rs.next()) {
			QnaOpinionDto opinionDto = new QnaOpinionDto();
			opinionDto.setOpinion_no(rs.getInt("opinion_no"));
			opinionDto.setOpinion_content(rs.getString("opinion_content"));
			opinionDto.setRegist_time(rs.getDate("regist_time"));
			opinionDto.setBoard_no(rs.getInt("board_no"));
			opinionDto.setOpinion_writer(rs.getString("opinion_writer"));
			list.add(opinionDto);

		}
		con.close();
		return list;
		
	}

	//댓글 삭제 기능
	public void delete(QnaOpinionDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete qna_opinion where opinion_no=? and board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getOpinion_no());
		ps.setInt(2, dto.getBoard_no());
		ps.execute();
		
		con.close();
	}
	
	//댓글 수정
	public void update(QnaOpinionDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update qna_opinion set opinion_content = ? where opinion_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getOpinion_content());
		ps.setInt(2, dto.getOpinion_no());
		ps.execute();
		
		con.close();
	}
	
	//페이징을 이용한 목록
	public List<QnaOpinionDto> pagingList(int board_no, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
		String sql = 	"select * from(" + 
							"select rownum rn, TMP.* from(" + 
								"select * from qna_opinion where board_no=? order by opinion_no desc" + 
							")TMP" + 
						") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
				
		List<QnaOpinionDto> list = new ArrayList<>();
		while(rs.next()) {
			QnaOpinionDto dto = new QnaOpinionDto();
			dto.setOpinion_no(rs.getInt("opinion_no"));
			dto.setOpinion_content(rs.getString("opinion_content"));
			dto.setRegist_time(rs.getDate("regist_time"));
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setOpinion_writer(rs.getString("opinion_writer"));
			list.add(dto);

			}
			con.close();
				
			return list; 
	}
			
	//댓글 개수를 구하는 메소드 
	public int getCount(QnaOpinionDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
		String sql = "select count(*) from qna_opinion where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getBoard_no());
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		
		return count; 
	}
}