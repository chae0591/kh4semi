<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>

<%
	QnaBoardDao qnaboardDao = new QnaBoardDao();
	QnaBoardDto qnaboardDto = new QnaBoardDto();
	List<QnaBoardDto> list = qnaboardDao.select();
		
	/* int member_no;
	boolean isMember;
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto;

	try{
		//로그인한 회원이면
		member_no = (int)session.getAttribute("check");
		memberDto = memberDao.find(member_no);
		isMember = memberDto.getMember_id().equals(qnaboardDto.getBoard_writer());
	}catch(Exception e) {
		//로그인 안했다면
		isMember = false;
	} */
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
	.article > .text-box {
		height: 140px;
		magine: 1rem;
		padding: 0.5rem;
	}
	.pagination {
		text-align: center;
		width: 100%;
	}
	
	.pagination > ul> li {
		display: inline-block;
		text-decoration: none;
	}
</style>

<script>
	$(function(){
		//글쓰기 버튼 눌렀을때
		$(".write-btn").click(function(){
			//로그인한 회원이 누르면 write.jsp로 이동
			location.href = "write.jsp"
			/* boolean isMember;
			
			if(isMember){
				location.href = "write.jsp"
			}
			else{
				location.href = "member/login.jsp"
			} */
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
			<li><a href="#">최신순</a></li>
			<li><a href="#">댓글순</a></li>
		</ul>
	</div>
	
	<div class="article">
	
	<!-- 게시글 리스트 -->
	<div>
		<h5>답변을 기다려요!</h5>
	</div>
	
	<div class="text-box">
		<%for(QnaBoardDto dto : list){ %>
			<div><p><%=dto.getRegist_time()%></p></div>
			<div>
				<h4>질문</h4>
				<h4 class="detail-enter"><a href="detail.jsp?board_no=<%=dto.getBoard_no()%>"><%=dto.getBoard_title()%></a></h4>
			</div>
					
			<div><p class="detail-enter"><a href="detail.jsp?board_no=<%=dto.getBoard_no()%>"><%=dto.getBoard_content()%></a></p></div>
					
			<div><p><%=dto.getBoard_writer()%>님의 질문입니다</p></div>	
		<%} %>
	</div>
	
	</div>
	
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

<jsp:include page="/template/footer.jsp"></jsp:include>