<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>회원 탈퇴가 완료되었습니다! </h2>

	
<div>

	<form action="<%=request.getContextPath()%>/index.jsp" method="get">
	    <input type="submit" class="btn btn-warning form-control" value="홈으로 이동"/>
	</form>

</div>
