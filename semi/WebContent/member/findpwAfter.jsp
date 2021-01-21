<%@page import="beans.MemberDto"%>
<%@page import="beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<%
	int member_no = (int)session.getAttribute("check");
	String member_pw = (String)session.getAttribute("pw");

	MemberDao dao = new MemberDao();
	MemberDto dto = dao.find(member_no); 
	
	
%>

<body>
	<div>
		회원님의 비밀번호는 <%=dto.getMember_pw()%>
	</div>
</body>
</html>