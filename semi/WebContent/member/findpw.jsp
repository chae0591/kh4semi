<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
	<form method="post" action="findpw.do">
		<h3>비밀번호 찾기</h3>
		<div>
			<input type ="text" placeholder="아이디" name ="member_id" maxlength='20'>
		</div><br>
		<div>
			<input type ="text" placeholder="닉네임" name ="member_nick" maxlength='20'>
		</div><br>
		<div>
			<input type="submit" value="비밀번호 찾기">
		</div> 
		
	</form>
</body>
</html>