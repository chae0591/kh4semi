<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login page</title>
</head>

<script>
	function LoginByClick() {
		
	}
</script>
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
			
			<%if(request.getParameter("error")!=null){ %>
			<script>alert('로그인 실패! \n아이디와 비밀번호를 확인해주세요.');</script>
			<%} %>
					
			
			<div>
	           	<span>
	           		<a href="findpw.jsp" >비밀번호 찾기</a>
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