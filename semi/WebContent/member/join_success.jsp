<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.button {
		background-color:#DFF9F9; 		  border: none;
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
<div class="outbox" style="width:640px">
	<div class="center">
		<h3>회원가입이 완료되었습니다 ! </h3>
	</div>
	<div class="center">
		<a href="../index.jsp" class="button center">홈으로 돌아기기</a><br>
		<a href="../member/login.jsp" class="button center">로그인하기</a>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>		
		