<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
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
	
	.margin {
		margin: 50px; 
	}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>
    
<h2 class="center margin">회원 탈퇴가 완료되었습니다! </h2>

	
<div>

	<form action="<%=request.getContextPath()%>/index.jsp" method="get" class="center margin">
	    <input type="submit" class="btn btn-warning form-control button" value="홈으로 이동"/>
	</form>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>		

