<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>    

<%
	//상세보기처럼 번호를 이용하여 글 불러오기
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	QnaBoardDao dao = new QnaBoardDao();
	QnaBoardDto dto = dao.find(board_no);

%>    

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="outbox" style="width:800px">
	<div class="row center">
		<h2>게시글 수정</h2>
	</div>
	
	<form action="<%=request.getContextPath()%>/qna_board/edit.do" method="post">
	
	<!-- 사용자는 보이지 않는 board_no 첨부 -->
	<input type="hidden" name="board_no" value="<%=dto.getBoard_no()%>">
	
	<div class="row">
		<label>제목</label>
		<input type="text" class="input" name="board_title" required value="<%=dto.getBoard_title()%>">
	</div>
	
	<div class="row">
		<label>내용</label>
		<textarea name="board_content" class="input" required rows="10"><%=dto.getBoard_content()%></textarea>
	</div>
	
	<div class="row">
		<input type="submit" class="input" value="등록">
	</div>
	 
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>