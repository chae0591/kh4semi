<%@page import="beans.MemberDto"%>
<%@page import="beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int member_no = (int)session.getAttribute("check");
	MemberDao dao = new MemberDao();
	MemberDto dto = dao.find(member_no); 
%>
<style>
	.font {
	    font-family :'나눔고딕', 'Malgun Gothic', sans-serif;
	}
	table.myList {
		border-collapse: collapse;
	    text-align: left;
	    line-height: 1.5;
	    font-family :'나눔고딕', 'Malgun Gothic', sans-serif;
	    
	}
	table.myList thead th{
		padding: 10px;
		  font-weight: bold;
		  vertical-align: top;
		  color: #369;
		  border-bottom: 3px solid #036;
	}
	table.myList tbody th{
		 width: 150px;
		  padding: 10px;
		  font-weight: bold;
		  vertical-align: top;
		  border-bottom: 1px solid #ccc;
		  background: #DFF9F9;
	}
	
	table.myList td {
		 width: 350px;
		  padding: 10px;
		  vertical-align: top;
		  border-bottom: 1px solid #ccc;
	}
	.button {
		background-color: #DFF9F9;
		  border: none;
		  color: black;
		  padding: 15px;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 20px;
		  cursor: pointer;
		  width: 400px;
		  margin: 2px;
	}
</style>

<div class="outbox" style="width:400px">
	<div class="row center font">
		<h2>회원 정보</h2>
	</div>
	<div class="row">
		<table class="myList table table-border">
			<tbody>
				<tr>
					<th width="25%">회원 번호</th>
					<td><%=dto.getMember_no()%></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><%=dto.getMember_id()%></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><%=dto.getMember_nick()%></td>
				</tr>
				<tr>
					<th>가입일</th>
					<td><%=dto.getMember_join()%></td>
				</tr>
			</tbody> 
		</table>
	</div>
	
	<!-- 하단 매뉴 -->
<!-- 	<div class="row center font">
		<a href="pw.jsp">비밀번호 변경하기</a>
	</div>
	 -->
	<form action="pw.jsp">
		<input type="submit" class="center button" value="비밀번호 변경하기"> 
	</form>
	
	
	<!-- <div class="row center font">
		<a href="nickedit.jsp">닉네임 변경하기</a>
	</div> -->
	
	<form action="nickedit.jsp">
		<input type="submit" class="center button" value="닉네임 변경하기">
	</form>
	
	<!-- 
	<div class="row center font" onclick="return confirm('회원탈퇴 하시겠습니까?');">
		<a href="delete.do">회원 탈퇴하기</a>
	</div> -->
	
	<form action="delete.do" onclick="return confirm('회원탈퇴 하시겠습니까?');">
		<input type="submit" class="center button" value="회원탈퇴 하기">
	</form>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>		
