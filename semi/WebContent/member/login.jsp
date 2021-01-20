<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login page</title>
</head>
<body>
<form method="post" action="login.do">
	<div>
		<h3>디비고 로그인 하기</h3>
			<div>
				<input type ="text" placeholder="아이디" name ="member_id" maxlength='20'>
			</div><br>
			<div>
				<input type ="password" placeholder="비밀번호" name ="member_pw" maxlength='20'>
			</div><br>
			
			<div>
	           	<span>
	           		<a href="#" >비밀번호 찾기</a>
	           	</span>
	        </div><br>
	        <div>
	        	<input type="submit" class="" value="로그인">
	        </div><br>
	        <div>
	        	디비고<a href="join.jsp"> 회원가입하기</a>
	        </div>
	</div>
</form>
</body>
</html>