<%@page import="beans.MemberDto"%>
<%@page import="beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int member_no = (int)session.getAttribute("check");
	MemberDao dao = new MemberDao();
	MemberDto dto = dao.find(member_no); 
%>


<div class="outbox" style="width:400px">
	<div class="row center">
		<h2>회원 정보</h2>
	</div>
	<div class="row">
		<table class="table table-border">
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
	<div class="row center">
		<a href="pw.jsp">비밀번호 변경하기</a>
	</div>
	<div class="row center">
		<a href="nickedit.jsp">닉네임 변경하기</a>
	</div>
	<div class="row center">
		<a href="delete.do">회원 탈퇴하기</a>
	</div>
	
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>		
