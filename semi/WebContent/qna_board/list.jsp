<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	//page 
	int boardSize = 10;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e){
		p = 1;
	}
	
	int endRow = p * boardSize; 
	int startRow = endRow - boardSize + 1; 
%>

<!-- 출력해서 확인 -->
<%-- <h1> p = <%=p%>, startRow = <%=startRow%>, endRow = <%=endRow%></h1> --%>

<%
	//목록 검색을 위해 필요한 프로그래밍 코드 
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean isSearch = type != null && key != null; 
	
	//목록 가져오기
	QnaBoardDao dao = new QnaBoardDao();
	List<QnaBoardDto> list;
	
	//댓글 목록 구하기
	String isOrder = request.getParameter("isOrder");
	if(isOrder == null){
		if(isSearch) {
			list= dao.pagingList(type, key, startRow, endRow);
		}
		else {
			list = dao.pagingList(startRow, endRow);
		}
	}else{
		if(isSearch) {
			list= dao.pagingListByOpinion(type, key, startRow, endRow);
		}
		else {
			list = dao.pagingListByOpinion(startRow, endRow);
		}
	}
%>

<%
	//	페이지 네비게이터 계산 코드를 작성

	//	블록 크기를 설정
	int blockSize = 10;

	//	페이지 번호에 따라 시작블록과 종료블럭을 계산
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;

	//	endBlock이 마지막 페이지 번호보다 크면 안된다 = 데이터베이스에서 게시글 수를 구해와야 한다.
	//	int count = 목록개수 or 검색개수;
	int count;
	if(isSearch){
		count = dao.getCount(type, key); 
	}
	else{
		count = dao.getCount();
	}

	//	페이지 개수 = (게시글수 + 9) / 10 = (게시글수 + 페이지크기 - 1) / 페이지크기
	int pageSize = (count + boardSize - 1) / boardSize;

	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>

<style>
	
		/* width:100%;
		height: auth;
		min-height: 700px;
		margine: 0;
		padding: 0;
		border: 1px solid #ededed; */
	
	.information > span, span > a {
		margin-bottom: 10px;
		font-size: 12px;
   	 	line-height: 20px;
    	font-weight: 500;
		color: #888888;
	}
	.category li {
		margin-bottom: 10px;
		font-size: 14px;
   	 	line-height: 20px;
    	font-weight: 500;
		color: #000;
	}
	.main-title{
		margin-bottom: 10px;
		font-size: 20px;
   	 	line-height: 20px;
    	font-weight: 500;
		color: #000;
		text-align: center;
	}
	<!-- 게시글 -->
	.text-outbox {
		width: 700px;
		padding: 0.5rem;
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    	white-space: normal;
	}
	.text-box {
		width: 700px;
		height: 130px;
		border: 1px solid #ededed;
    	border-radius: 10px;
    	margin-bottom: 10px;
	}
	.question {
		font-size: 14px;
   	 	line-height: 20px;
    	font-weight: 500;
		color: #00EDF5;
	}
	.title {
	    font-size: 16px;
    	line-height: 24px;
    	font-weight: 500;
    	color: #222;
	}
	.content{
		width: 100%;
		font-size: 14px;
		line-height: 24px;
    	font-weight: 300;
    	color: #8c8c8c;
    	display: inline-block;
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    	white-space: normal;
    	line-height: 1.5;
    	height: 3em;
    	word-wrap: break-word;
    	display: -webkit-box;
    	-webkit-line-clamp: 2;
    	-webkit-box-orient: vertical;
	}
	.member {
		font-size: 14px;
    	line-height: 24px;
    	font-weight: 500;
    	color: #222;
	}
	.who {
		font-size: 14px;
    	line-height: 24px;
    	font-weight: 300;
    	color: #8c8c8c;
	}
	.time, .vote, .heart, .reply, .opinion{
		font-size: 14px;
    	line-height: 24px;
    	font-weight: 300;
    	color: #8c8c8c;
	}
	
	<!-- 페이지 네이션 -->
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
	/* .pagination > ul> li:hover {
		display: inline-block;
		text-decoration: none;
		font-size: 14px;
    	line-height: 24px;
    	font-weight: 500;
    	color: #00EDF5;
    	border-color: #e5e5e5;
	} */
	.board_title {
		width:100%;
		height:20px;
		text-overflow:ellipsis; 
		overflow:hidden;
	}
	.board_title > a{
		width:100%;
		text-overflow:ellipsis; 
		overflow:hidden;
		white-space:nowrap;
	}
	.search-btn {
		width: 50px;
		height: 30px;
    	border: 1px solid  #00EDF5;
    	background-color: #8c8c8c;
    	color: #fff;
    	font-size: 14px;
    	border-radius: 10px;
	}

</style>

<jsp:include page="/template/header.jsp"></jsp:include>
<script>
$(function(){
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
});
</script>
		
	
	<div class="information">
		<span><a href="/semi">전체</a></span>
		<span> > </span>
		<span><a href="/semi/qna_board/list.jsp">여행Q&A</a></span>
	</div>
	<!— 최신순, 댓글순 —>
	<div class="category">
		<ul>
		<%QnaBoardDto boardDto = new QnaBoardDto();%>
			<%if(isSearch){%>
				<li class="dateRank"><a href="list.jsp?isSearch&type=<%=type%>&key=<%=key%>">최신순</a></li>
			<%}else{ %>
				<li class="dateRank"><a href="list.jsp?isSearch">최신순</a></li>
			<%} %>
			<%if(isSearch){%>
				<li class="countRank"><a href="list.jsp?isOrder&type=<%=type%>&key=<%=key%>">댓글순</a></li>
			<%}else{ %>
				<li class="countRank"><a href="list.jsp?isOrder">댓글순</a></li>
			<%} %>
		</ul>
	</div>
	
	<span class="main-title">답변을 기다려요!</span>
	
 	<div class="text-outbox">
	<%for(QnaBoardDto dto : list){ %>
			<div class="text-box">
			<!-- 타이틀 -->
			<span class="question">질문</span><span class="title"><a href="detail.jsp?board_no=<%=dto.getBoard_no()%>" style="float: left"><%=dto.getBoard_title()%></a></span>		
			<!-- 내용 -->				
			<p class="content"><a href="detail.jsp?board_no=<%=dto.getBoard_no()%>"><%=dto.getBoard_content()%></a></p>
			<!-- 작성자 -->
			<span class="member"><%=dto.getBoard_writer()%></span><span class="who">님의 질문입니다</span>
			<!-- 작성날짜 -->
			<span class="time"><%=dto.getRegist_time()%></span>
			<!-- 좋아요 -->
			<span class="heart">♡</span><span class="vote"><%=dto.getVote()%></span>
			<!-- 댓글개수 -->
			<span class="reply">댓글</span><span class="opinion"><%=dto.getOpinion()%></span>
			</div>
	<%} %>
	</div>
	
	<div class="row right">
		<button class="write-btn input input-inline">글쓰기</button>
	</div>
	<!— 검색창 —>
	<form action="list.jsp" method="post">
	<div class="row">
		<select name="type" class="input input-inline">
			<option value="board_title" <%if(type!=null&&type.equals("board_title")){%>selected<%}%>>제목</option>
			<option value="board_writer" <%if(type!=null&&type.equals("board_writer")){%>selected<%}%>>작성자</option>
		</select>
		<%if(isSearch){ %>
		<input type="text" class="input input-inline" name="key" required value="<%=key%>">
		<%}else{ %>
		<input type="text" class="input input-inline" name="key" required>
		<%} %>
		<input type="submit" class="input input-inline search-btn" value="검색">
	</div>
	</form>
	
	
	<!— 페이지 네비게이션 —>
	<div class="pagination">
		<ul>
			<%if(isSearch) {%>
				<li><a href="list.jsp?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
			<%}else { %>
				<li><a href="list.jsp?p=<%=startBlock-1%>">&lt;</a></li>
			<%} %>
			<%for(int i =startBlock; i<=endBlock; i++){ %>
				<li>
				<%if(isSearch){ %>
					<!— 검색용 링크 —>
					<a href="list.jsp?p=<%=1%>&type=<%=type%>&key=<%=key%>"><%=i%></a>
				<%}else{ %>
					<!— 목록용 링크 —>
					<a href="list.jsp?p=<%=i%>"><%=i%></a>
				<%} %>
				</li>
			<%} %>
			
			<%if(isSearch){ %>
				<li><a href="list.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
			<%}else{ %>
				<li><a href="list.jsp?p=<%=endBlock+1%>">&gt;</a></li>
			<%} %>
		</ul>
	</div>
	
<jsp:include page="/template/footer.jsp"></jsp:include>