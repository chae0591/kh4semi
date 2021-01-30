<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<script>
window.location.replace('<%=request.getContextPath()%>/member/login.jsp');
</script>
<div class="outbox center" style="width:500px">
	<div class="row">
		<h2>이용 권한이 없습니다</h2>
		<h3>
		로그인 페이지로 이동합니다.
		</h3>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>