<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>
</head>
<body>
	<h3>디비고 회원가입 하기</h3>
		<form method="post" action="join.do">
			<div>
				<input type ="text" placeholder="아이디" name ="member_id" maxlength='20' required>
			</div><br>
			<div>
		        <input type ="password" placeholder="비밀번호" name ="member_pw" maxlength='20' required>
			</div><br>
			<div>
				<input type ="text" placeholder="닉네임" name ="member_nick" maxlength='20' required>
			</div><br>
			<input type="submit" value="회원가입">
		</form>
</body>
</html>