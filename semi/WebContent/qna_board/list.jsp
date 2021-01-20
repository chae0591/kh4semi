<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>

<%
	//페이지 인쇄에 필요한 데이터 준비 - QnaBoardDao 연결
	QnaBoardDao dao = new QnaBoardDao();
	List<QnaBoardDto> list = dao.select();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="row right">
			<a href="write.jsp">글쓰기</a>
		</div>
		<div class="row">
			<table class="table table-border">
				<thead>
					<tr>
						<th>번호</th>
						<th width="40%">제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<%for(QnaBoardDto dto : list){ %>
					<tr>
						<td><%=dto.getBoard_no()%></td>
						<td>
							<a href="detail.jsp?board_no=<%=dto.getBoard_no()%>">
								<%=dto.getBoard_title()%>
							</a>
						</td>
						<td><%=dto.getBoard_writer()%></td>
						<td><%=dto.getRegist_time()%></td>
						<td><%=dto.getVote()%></td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>

<jsp:include page="/template/footer.jsp"></jsp:include>