package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JdbcUtil;

public class MemberDao {
	public static final String USERNAME = "project5";
	public static final String PASSWORD = "project5";
	
	//로그인을 위한 맴버찾기 
	public MemberDto find(String member_id) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from member where member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, member_id) ;
		ResultSet rs = ps.executeQuery(); 
		
		MemberDto dto;
		if(rs.next()) {
			dto = new MemberDto(); 
			dto.setMember_no(rs.getInt("member_no"));
			dto.setMember_id(rs.getString("member_id"));
			dto.setMember_pw(rs.getString("member_pw"));
			dto.setMember_nick(rs.getString("member_nick"));
			dto.setMember_join(rs.getDate("member_join"));
		}
		else {
			dto = null;
		}
		
		con.close();
		
		return dto; 
	}
	
	//로그인 
	public boolean login(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from member where member_id=? and member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_id());
		ps.setString(2,dto.getMember_pw());
		ResultSet rs = ps.executeQuery();
		
		boolean result = rs.next();
		
		con.close();
		
		return result; 
	}
	
	
	//회원가입
}
