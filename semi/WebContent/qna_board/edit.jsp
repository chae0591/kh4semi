<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	QnaBoardDao dao = new BoardDao

%>    
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="outbox" style="width:800px">
	<div class="row center">
		<h2>게시글 수정</h2>
	</div>
	
	<form action="<%=request.getContextPath()%>/qna_board/edit.do" method="post">
	
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