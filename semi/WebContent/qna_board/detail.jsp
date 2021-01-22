<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>

<!-- 
	상세보기 페이지
	이 페이지는 무조건 "어떤 항목을 볼 것인지에 대한 값"이 존재해야 한다
	일반적으로 primary key가 이 역할을 수행한다.
	
	즉, 이 페이지에서는 시작하자마자 전달되는 데이터를 받아서 데이터베이스에 존재하는 값을 불러온 뒤 출력해야 한다.
	게시판에서는 게시글번호(board_no)가 해당된다. 
-->
<%
	//번호 받기 - QnaBoardDao 연결
	int board_no = Integer.parseInt(request.getParameter("board_no"));

	//단일검색
	QnaBoardDao dao = new QnaBoardDao();
	QnaBoardDto dto = dao.find(board_no);
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	html, body{
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
	}
	.aside {
		border: 1px solid black;
		float: left;
		width: 20%;
		height: 800px;
	}
	.aside li{
		list-style: none;
	}
	.article {
		border: 1px solid black;
		float: right;
		width: 80%;
		height: 800px;
	}
</style>
<script>
	$(function(){
		$(".edit-btn").click(function(){
			location.href = "edit.jsp?board_no=<%=board_no%>";
		});
		
		$(".delete-btn").click(function(){
			location.href = "delete.do?board_no=<%=board_no%>";
		});
	});

</script>
<!-- 상단 부분 -->
	<div>
		<a href="/semi">전체</a>
		<span> > </span>
		<a href="/semi/qna_board/list.jsp">여행Q&A</a>
	</div>
	
	<!-- 최신순, 댓글순 -->
	<div class="aside">
		<ul>
			<li><a href="/semi/qna_board/list.jsp">목록으로</a></li>
		</ul>
	</div>
	
	<div class="article">

		<div class="out box">
			작성자 : <%=dto.getBoard_writer()%>
			<br><br>
			제목 : <%=dto.getBoard_title()%>
			<br><br>
			내용 : <%=dto.getBoard_content()%>
			<br><br>
			작성일 : <%=dto.getRegist_time()%>
			<br><br>
			좋아요 : <%=dto.getVote()%>
		</div>
		
	</div>

<button class="input edit-btn">수정</button>
<button class="input delete-btn">삭제</button>

<jsp:include page="/template/footer.jsp"></jsp:include>