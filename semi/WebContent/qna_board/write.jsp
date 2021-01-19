<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="outbox" style="width:800px">
	<div class="row center">
		<h2>게시글 작성</h2>
	</div>
	<div class="row center">상대방에 대한 인신공격은 예고 없이 삭제될 수 있습니다</div>
	
	<form action="write.do" method="post">
	
	<div class="row">
		<label>제목</label>
		<input type="text" class="input" name="board_title" required>
	</div>
	
	<div class="row">
		<label>내용</label>
		<textarea name="board_content" class="input" required rows="10"></textarea>
	</div>
	
	<div class="row">
		<input type="submit" class="input" value="등록">
	</div>
	 
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>