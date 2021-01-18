<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	QnaBoardDao dao = new QnaBoardDao();
	QnaBoardDto dto = dao.find(board_no);
%>

글번호 : <%=dto.getBoard_no()%>
<br><br>
작성자 : <%=dto.getBoard_writer()%>
<br><br>
제목 : <%=dto.getBoard_title()%>
<br><br>
내용 : <%=dto.getBoard_content()%>
<br><br>
작성일 : <%=dto.getRegist_time()%>
</html>