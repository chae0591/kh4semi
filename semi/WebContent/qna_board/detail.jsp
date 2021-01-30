<%@page import="java.text.SimpleDateFormat"%>
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

	//단일검색 - 게시글 정보 조회
	QnaBoardDao boardDao = new QnaBoardDao();
	QnaBoardDto boardDto = boardDao.find(board_no);
	
	//회원만 수정, 삭제 가능 하도록 구현
	MemberDao memberDao = new MemberDao();
	MemberDto writerDto = memberDao.find(boardDto.getBoard_writer());

	//게시글 작성한 회원, 본인인가?
	int member_no;
	boolean isMember;
	MemberDto memberDto = null;

	try{
		member_no = (int)session.getAttribute("check");
		memberDto = memberDao.find(member_no);
		isMember = memberDto.getMember_id().equals(boardDto.getBoard_writer());
	}catch(Exception e) {
		isMember = false;
	}
%>

<% 
	//댓글 목록 구하기
	QnaOpinionDao opinionDao = new QnaOpinionDao();
	/* List<QnaOpinionDto> list = opinionDao.select(board_no); */
%>

<%
 	//댓글 목록 페이지 분할 계산 코드를 작성
	int opinionSize = 5;

	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();//강제예외
	}
	catch(Exception e){
		p = 1;
	}
	
 	//p의 값에 따라 시작 row번호와 종료 row번호를 계산
	int endRow = p * opinionSize;
	int startRow = endRow - opinionSize + 1;
%>  

<%
	List<QnaOpinionDto> list = opinionDao.pagingList(board_no, startRow, endRow);
%>

<%
 	//페이지 네비게이터 계산 코드를 작성
 	//블록 크기를 설정
	int blockSize = 5;
 	
	//페이지 번호에 따라 시작블록과 종료블럭을 계산
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
 	//endBlock이 마지막 페이지 번호보다 크면 안된다 = 데이터베이스에서 게시글 수를 구해와야 한다.
 	QnaOpinionDto opiniondto = new QnaOpinionDto();
 	opiniondto.setBoard_no(board_no);
	int count;
	count = opinionDao.getCount(opiniondto);
	
 	//페이지 개수 = (게시글수 + 9) / 10 = (게시글수 + 페이지크기 - 1) / 페이지크기
	int pageSize = (count + opinionSize - 1) / opinionSize;
	
	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>

<%-- <h1>count = <%=count%>, Size = <%=pageSize%>, startBlock = <%=startBlock%>, endBlock = <%=endBlock%></h1> --%>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	.img-container img{
		max-width:100%;
	}
	html, body {
		width: 100%;
		height: 100%;
		margin: 0;
		padding: 0;
	}
	.btn{
		cursor: pointer;
	}
	div, span, a {
		border: none !important;
	}
	hr {
		height: 2px;
		color: #999;
		background-color: #ddd;
		border: none;
	}
	.outbox::after {
		width:100%;
		height: auth;
		min-height: 700px;
		display: block;
		clear: both;
		content: "";
	}
	.padding-top-20 {
  		padding-top: 20px;
	}
	.padding-top-10 {
  		padding-top: 10px;
	}
	.padding-bottom-20 {
  		padding-bottom: 20px;
	}
	.padding-bottom-10 {
  		padding-bottom: 10px;
	}
	.padding-left-10 {
  		padding-bottom: 10px;
	}
	.gray {
		color: #999;
	}
	.border-gray-1 {
		border: 1px solid #999 !important;
  		border-radius: 10px;
	}
	.contents{
		min-height: 50px;
    	margin: 0 auto;
    	padding: 10px 0 0 ;
    	border-bottom: 1px solid #eeeeee;
    }
    .contents span{
    	float: left;
    	position: relative;
    	height: 40px;
    	line-height:40px;
    	color : #bbbbbb;
    	font-size: 14px;
    	font-weight: 500;
    }
    .contents a{
    	display: block;
    	float: left;
    	position: relative;
    	height: 40px;
    	line-height:40px;
    	color: #666666;
    	font-size: 14px;
    	font-weight: 500;
    }
	aside {
		float: left;
		width: 20%;
		height: auth;
		min-height: 700px;
		padding: 1.5rem;
		position: relative;
	}
	aside li{
		list-style: none;
	}
	article {
		float: right;
		width: 80%;
		height: auth;
		min-height: 700px;
		padding: 1rem;
		position: relative;
	}
	.container-content {
		padding: 10px;
	}
	.opinion-box {
		width: 100%;
		height: auto;
		margin: 10px;
		border: 1px solid #999;
	}
	.opinion-list-box {
		width: 100%;
	}
	.pagination {
		text-align: center;
		width: 100%;
	}
	.pagination > ul> li {
		display: inline-block;
		text-decoration: none;
		font-size: 14px;
    	line-height: 24px;
    	font-weight: 300;
    	color: #e5e5e5;
	}	
</style>
<script>
	$(function(){
		//글쓰기버튼 -> write.jsp
		$(".write-btn").click(function(){
			var sessionCheck = '<%=session.getAttribute("check")%>';
			if(! sessionCheck == '' && sessionCheck == 'null'){
				alert("로그인이 필요합니다.")
				location.href = "<%=request.getContextPath()%>/member/login.jsp";
			}
			else{
				location.href = "<%=request.getContextPath()%>/qna_board/write.jsp";
			}
		});
		
		//수정버튼 -> edit.jsp
		$(".edit-btn").click(function(){
			location.href = "edit.jsp?board_no=<%=board_no%>";//절대경로
		});
		
		//삭제버튼 -> delete.do
		$(".delete-btn").click(function(){
			location.href = "delete.do?board_no=<%=board_no%>";//절대경로
		});
		
		//목록으로 -> list.jsp
		$(".before-btn").click(function(){
			location.href = "list.jsp";
		});
		
		//좋아요 버튼 -> vote_write_delete.do
		$(".vote-btn").click(function(){
			var sessionCheck = '<%=session.getAttribute("check")%>';
			if(! sessionCheck == '' && sessionCheck == 'null'){
				alert("로그인이 필요합니다.")
				location.href = "<%=request.getContextPath()%>/member/login.jsp";
			}
			else{	
			location.href = "vote_write_delete.do?board_no=<%=board_no%>";//절대경로
			}
		});
		
		<!-- 댓글 버튼 -->
		//최초에 수정화면 숨김 처리
		$(".opinion-edit").hide();
		
		//수정 버튼을 누르면 일반화면을 숨기고 수정화면 표시
		//a태그이므로 기본이벤트를 차단해야한다
		$(".opinion-edit-btn").click(function(e){
			e.preventDefault();
			
			$(this).parents(".opinion-normal").hide();
			$(this).parents(".opinion-normal").next().show();
		});	
		
		//작성 취소 버튼을 누르면 수정화면을 숨기고 일반화면 표시
		$(".opinion-edit-cancel-btn").click(function(){
			$(this).parents(".opinion-edit").hide();
			$(this).parents(".opinion-edit").prev().show();
		});
		
		//댓글 등록 눌렀을때 로그인 여부 확인
		$(".input-btn").click(function(){
			var sessionCheck = '<%=session.getAttribute("check")%>'
			if(! sessionCheck == '' && sessionCheck == 'null'){
				alert("로그인이 필요합니다.")
				//로그인창으로 이동
				location.href = "<%=request.getContextPath()%>/member/login.jsp";
				//폼 전송 막기
				return false;
			}
			else{
				location.href = "<%=request.getContextPath()%>/qna_board/opinion_write.do";
			}
		});
	});

</script>



<!-- 상단 부분 -->
<div class="contents left">
	<a href="<%=request.getContextPath()%>">전체</a><span> &gt; </span> 
	<a href="<%=request.getContextPath()%>/qna_board/list.jsp">여행Q&amp;A</a>
</div>
	
<div class="outbox">

	<aside>
		<div class="container-content center">
			<div class="padding-top-20"> 
				<img src="https://placeimg.com/100/100/summer" alt="Avatar" style="border-radius: 50%">
			</div>
			<br>
			<h3>
				<%=writerDto.getMember_nick()%>
			</h3>
			<div class="gray">여행작가</div>
			<div>
				<a class="gray"
					href="list.jsp?type=board_writer&key=<%=boardDto.getBoard_writer()%>">
					작성글 (<%=boardDao.getCount("board_writer", boardDto.getBoard_writer())%>)
				</a>
			</div>
		</div>
	</aside>
	
	<article>
	<!-- 게시글 -->
		<div class="container-content">
			<h3> <%=boardDto.getBoard_title()%></h3>

			<div class="regist_time">
				<div>작성일 : <%=boardDto.getRegist_time()%></div>
			</div>
			<hr>
			<div style="word-break: break-all;" class="container-content padding-top-20 padding-bottom-20 img-container"><%=boardDto.getBoard_content()%></div>
			<hr>
			<div class="container-content gray">
				<span class="btn input input-inline vote-btn">좋아요(<%=boardDto.getVote()%>)</span>
			<!-- 로그인한 회원만 볼 수 있도록 구현 -->	
			<%if(isMember){ %>
				<span class="btn input input-inline write-btn">글쓰기</span>
				<span class="btn input input-inline edit-btn">수정</span>
				<span class="btn input input-inline delete-btn">삭제</span>
				<span class="btn input input-inline before-btn">목록으로</span>
			<%}else{ %>
				<span class="btn input input-inline vote-btn">좋아요</span>
				<span class="btn input input-inline write-btn">글쓰기</span>
				<span class="btn input input-inline before-btn">목록으로</span>
			<%} %>
			</div>
			<hr>
		</div>
		
	<!-- 댓글 작성란 -->
	<div class="opinion-box">
		<div class="gray padding-bottom-10">
			댓글 (<%=list.size()%>)
		</div>
		<form style="padding-left:10px;" action="opinion_write.do" method="post">
				<input type="hidden" name="board_no" value="<%=board_no%>">
				<div class="row">
					<textarea class="input form-control" name=opinion_text required rows="3"
						placeholder="댓글 작성"></textarea>
				</div>
				<br>
				<div class="row">
					<input type="submit" value="댓글 작성" class="input btn btn-info">
				</div>
			</form>
	</div>		
			
	<!-- 댓글 목록 -->	
	<div class="opinion-list-box">
		<%for(QnaOpinionDto opinionDto : list){ %>
							
		<!-- 일반 출력 화면 -->
		<div class="opinion-normal padding-top-10 padding-left-10 row left">
			<div>
				<%=opinionDto.getOpinion_writer()%>
				<%if(boardDto.getBoard_writer().equals(opinionDto.getOpinion_writer())){ %>
					<span class="gray">(작성자)</span>
				<%} %>
				<% 
					SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd E a h:mm:ss");
					String timeFormat = f.format(opinionDto.getRegist_time());
				%>
				<span class="gray">
				| <%=timeFormat%>
				</span>

				<!-- 수정은 댓글 작성자만, 삭제는 댓글 작성자, 게시글 작성자 가능 -->
				<%
					//댓글 작성자
					boolean isReplyWriter;
					try{
						isReplyWriter = memberDto.getMember_id().equals(opinionDto.getOpinion_writer());
					}catch(Exception e){
						isReplyWriter = false;
					}
				%>
				<%if(isReplyWriter){ %>
					<span class="gray"> | </span>
					<a href="#" class="opinion-edit-btn gray">수정</a>
				<%} %>
									
				<%if(isReplyWriter || isMember){ %>
					<span class="gray"> | </span>
					<a href="opinion_delete.do?opinion_no=<%=opinionDto.getOpinion_no()%>&board_no=<%=board_no%>" class="opinion-delete-btn gray">삭제</a>
				<%} %>
			</div>
			<div><%=opinionDto.getOpinion_content()%></div>
		</div>
							
			<!-- 수정을 위한 화면 : 댓글 작성자에게만 나오도록 조건 설정 -->
			<%if(isReplyWriter){ %>
			<div class="opinion-edit">
				<form action="opinion_write.do" method="post">
					<input type="hidden" name="opinion_no" value="<%=opinionDto.getOpinion_no()%>">
					<input type="hidden" name="board_no" value="<%=board_no%>">
					<div class="row padding-bottom-10">
						<textarea class="input form-control" name="opinion_content" required rows="5" 
						placeholder="댓글 작성"><%=opinionDto.getOpinion_content()%></textarea>
					</div>
					<div class="row">
						<input type="submit" value="댓글 수정" class="input btn btn-info input-inline opinion-re-edit-btn">
						<input type="button" value="작성 취소" class="input btn btn-info input-inline opinion-edit-cancel-btn">
					</div>
				</form>
			</div>
			<%} %>
	<%} %>
						
		</div>
		
		<!-- 페이지 네비게이션 -->
		<div class="row">
			<ul class="pagination">
				<li><a href="detail.jsp?p=<%=startBlock-1%>&board_no=<%=board_no%>">&lt;</a></li>
								
				<%for(int i=startBlock; i<=endBlock; i++){ %>
					<%if(i == p){ %>
						<li class="active"><a href="detail.jsp?p=<%=i%>&board_no=<%=board_no%>"><%=i%></a></li>
					<%}else{ %>
						<li><a href="detail.jsp?p=<%=i%>&board_no=<%=board_no%>"><%=i%></a></li>
					<%} %>
				<%} %>
								
				<%if(endBlock != pageSize){ %>
					<li><a href="detail.jsp?p=<%=endBlock+1%>&board_no=<%=board_no%>">&gt;</a></li>
				<%} %>
			</ul>
		</div>
	</article>
	
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>