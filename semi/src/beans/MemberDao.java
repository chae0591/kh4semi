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
<<<<<<< HEAD
	
	
=======
	public void register(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into member values (member_seq.nextval, ?, ?, ?, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_id());
		ps.setString(2, dto.getMember_pw());
		ps.setString(3, dto.getMember_nick());
		ps.execute();
		
		con.close(); 
	}
<<<<<<< HEAD
>>>>>>> refs/remotes/origin/main
=======
	
	//단일검색 
	public MemberDto find(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from member where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
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
	
	//비밀번호 변경 DAO
	public boolean editPassword(int member_no, String member_pw, String change_pw) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "update member set member_pw=? where member_no=? and member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, change_pw);
		ps.setInt(2, member_no);
		ps.setString(3, member_pw);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0; 
	}
	
	//닉네임 변경 
	public boolean editnick(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update member set member_nick=? where member_no=? and member_pw=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_nick());
		ps.setInt(2, dto.getMember_no());
		ps.setString(3, dto.getMember_pw());
		int count = ps.executeUpdate(); 
		
		con.close(); 
		
		return count > 0;
		
	}
	
	//회원탈퇴 DAO
	public boolean delete(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete member where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
>>>>>>> refs/remotes/origin/main
}
