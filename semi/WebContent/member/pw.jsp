<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<form action="pw.do" method="post">
	<div class="outbox" style="width:500px">
		<div class="row center">
			<h2>비밀번호 변경</h2>
		</div>
		<div class="row">
			<label>현재 비밀번호</label>
			<input type="password" name="member_pw" required class="input">
		</div>
		<div class="row">
			<label>변경할 비밀번호</label>
			<input type="password" name="change_pw" required class="input">
		</div>
		<div class="row">
			<input type="submit" value="비밀번호 변경" class="input">
		</div>
		
		<%if(request.getParameter("error") != null){ %>
		<div class="row" style="color:red;">
			현재 비밀번호가 일치하지 않습니다
		</div>
		<%} %>
	</div>
</form>



    
<jsp:include page="/template/footer.jsp"></jsp:include>		
    