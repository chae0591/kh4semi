<%@page import="beans.MemberDto"%>
<%@page import="beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
	//세션에 있는 회원번호(내 번호)를 이용하여 정보를 불러와 화면에 출력
	int member_no = (int)session.getAttribute("check");
	MemberDao dao = new MemberDao();
	MemberDto dto = dao.find(member_no);
%>    
    
<style>
	.font {
	    font-family :'나눔고딕', 'Malgun Gothic', sans-serif;
	}
	.button {
		background-color: #f3f6f7;
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

<jsp:include page="/template/header.jsp"></jsp:include>

<form action="edit.do" method="post">
	<div class="outbox font" style="width:500px">
		<div class="row center">
			<h2>회원 정보 수정</h2>
		</div>
		<div class="row">
			<label>Nickname</label>
			<input type="text" name="member_nick" required class="input" 
						placeholder="한글 2~10자" value="<%=dto.getMember_nick()%>">
		</div>
		
		<div class="row">
			<label>비밀번호를 한 번 더 입력하세요</label>
			<input type="password" name="member_pw" required class="input" placeholder="8~20자 영문 소문자/대문자/특수문자/숫자">
		</div>
		<div class="row">
			<input type="submit" value="정보수정" class="input button">
		</div>
		
		<%if(request.getParameter("error") != null){ %>
		<div class="row" style="color:red;">
			현재 비밀번호가 일치하지 않습니다
		</div>
		<%} %>
	</div>
</form>





    
<jsp:include page="/template/footer.jsp"></jsp:include>		
    
    