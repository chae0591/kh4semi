<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>

<%
	QnaBoardDao dao = new QnaBoardDao();
	List<QnaBoardDto> list = dao.select();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<style>
	.outbox {
		width: 100%;
		margin: 0;
	}
	
	.aside {
		float: left;
		width: 20%;
		height: 100%;
	}
	
	.article {
		float: right;
		width: 80%;
		height: 100%;
	}
	.article > .row {
		border: 1px solid black;
	}
	
	.pagination {
		text-align: center;
	}
	
	.pagination > ul> li {
		display: inline-block;
		text-decoration: none;
	}
</style>

<div class="outbox">

	<!-- 상단 부분 -->
	<div>
		<h5>전체 > 여행Q&A</h5>
	</div>
	
	<!-- 최신순, 댓글순 -->
	<div class="aside">
		<ul>
			<li>최신순</li>
			<li>댓글순</li>
		</ul>
	</div>
	
	<!-- 게시글 리스트 -->
	<div>
		<h5>답변을 기다려요!</h5>
	</div>
	
	<div class="aticle">
		<%for(QnaBoardDto dto : list){ %>
			<div class="row">
				<h4>질문</h4>
				<h4 class="detail-enter"><a href="detail.jsp?board_no=<%=dto.getBoard_no()%>"><%=dto.getBoard_title()%></a></h4>
				<p class="detail-enter"><a href="detail.jsp?board_no=<%=dto.getBoard_no()%>"><%=dto.getBoard_content()%></a></p>
				<p><%=dto.getRegist_time()%></p>
				<p><%=dto.getBoard_writer()%>님의 질문입니다</p>
			</div>
		<%} %>
		
		<div class="row right">
			<button class="write-btn">글쓰기</button>
		</div>
	
		<!-- 페이지 네비게이션 -->
		<div class="pagination">
			<ul>
				<li><a href="list.jsp?">이전</a></li>
			 	<li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">6</a></li>
                <li><a href="#">7</a></li>
                <li><a href="#">8</a></li>
                <li><a href="#">9</a></li>
                <li><a href="#">10</a></li>
				<li><a href="">다음</a></li>
			</ul>
		</div>
	
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>