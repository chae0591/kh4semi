<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>

<%
	QnaBoardDao dao = new QnaBoardDao();
	List<QnaBoardDto> list = dao.select();
%>
<%
	//페이지 네비게이터 계산 코드
	int startBlock = 1;
	int endBlock = 10;	

	int total = 0;
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
		border: 1px solid black;
	}
	
	.article {
		float: right;
		width: 80%;
		height: 100%;
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

<script>
	$(function(){
		//.write-btn을 누르면 글쓰기 페이지로 이동
		$(".write-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/qna_board/write.jsp";
		});
		
		//.detail-enter를 누르면 상세 페이지로 이동
		@(".detail-enter").click(function(){
			location.href = "<%=request.getContextPath()%>/qna_board/detail.jsp";
		});
	});
</script>

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
				<h4 class="detail-enter"><%=dto.getBoard_title()%></h4>
				<a class="detail-enter"><%=dto.getBoard_content()%></a>
				<a><%=dto.getRegist_time()%></a>
				<p><%=dto.getBoard_writer()%>님의 질문입니다</p>
			</div>
		<%} %>
		
		<div class="row right">
			<button class="write-btn">글쓰기</button>
		</div>
	
		<!-- 페이지 네비게이션 -->
		<div class="pagination">
			<ul>
				<li><a href="">이전</a></li>
			<%for(int i = startBlock; i <= endBlock; i++) {%>
				<li><a href=""><%total += i;%>total</a>
			<%} %>
				<li><a href="">다음</a></li>
			</ul>
		</div>
	
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>