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
    .bigTitle{
    	position: relative;
    	height: 60px;
    	line-height: 70px;
    	font-size: 23px;
    	font-weight: 700;
    	color: #454545;
    	border-bottom: 3px solid #454545;
    }
    .btn-box{
    	margin-top: 15px;
    }
    .container-tip{
		display: grid;
		grid-template-columns: repeat(2,1fr);
		grid-auto-rows: minmax(1em, auto);
		grid-gap: 1rem;
		justify-items: start;
		align-items: start;		
		padding: 10px 0 0 ;
		margin-left: 2.3rem;
	}

	.item{
		padding: 1rem;
		width: 500px;
	}
	.right-line{
    	float:right; 
    	margin-right: 1rem;
    }
    .title-line{
    	float:left; 
    	font-size:1.1em; 
    	font-weight:500;
    	display: inline-block;
    	width:260px;
    	margin-left: 0.5em;
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    	color: #222;
    }
    .title-line:hover{
    	text-decoration: underline;
    }
    .content-line{
    	font-size: 0.9em;
    	display: inline-block;
    	width:280px;
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
    	color: #8c8c8c;
    }
    .content-line:hover{
    	text-decoration: underline;
    }
    .border-gray-1 {
		border: 1px solid #999 !important;
  		border-radius: 10px;
	}
	div{ box-sizing: border-box; }
	
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
		list-style: none;
		display:inline-block;
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
    	border-radius: 10px;
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
		color: red;
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
	.pagination li {
		box-shadow: none;
	    cursor: default;
	}
	.pagination li:hover, li:active {
		box-shadow: none;
	    cursor: default;
	}
	.pagination > li > a{
		float: none;
	}
	.pagination > .remove-hover-style:hover {
		box-shadow: none;
	    /*border:1px solid gray;*/
	    cursor: default;
	}
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
		
	<!-- 상단 부분 -->
<div class="contents left">
	<a href="<%=request.getContextPath()%>">전체</a>
	<span> &gt; </span> 
	<a href="<%=request.getContextPath()%>/qna_board/list.jsp">여행Q&amp;A</a>
</div>

<div class="bigTitle">여행Q&amp;A</div>

	<!-- 최신순, 댓글순 -->
	<div class="category btn-box">
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
	
 	<div class="container-tip">
	<%for(QnaBoardDto dto : list){ %>
			<div class="item border-gray-1">
				<a href="detail.jsp?board_no=<%=dto.getBoard_no()%>">
					<span style="float:left" class="question">질문</span>
					<!-- 타이틀 -->
					<span class="title-line"> <%=dto.getBoard_title()%></span>
					<!-- 작성날짜 -->
					<span class="right-line"><%=dto.getRegist_time()%></span>
					<br><br>		
					<!-- 내용 -->				
					<span class="content-line" style="margin-left: 3.4rem"><%=dto.getBoard_content()%></span>
					<!-- 작성자 -->
					<br>
					<span style="margin-left: 3.6rem;"><%=dto.getBoard_writer()%></span><span style="color:#8C8C8C">님의 질문입니다</span>
					<!-- 좋아요 -->
					<span class="heart">♡</span><span class="vote"><%=dto.getVote()%></span>
					<!-- 댓글개수 -->
					<span class="reply">댓글</span><span class="opinion"><%=dto.getOpinion()%></span>
				</a>
			</div>
	<%} %>
	</div>
	
	<br>
	<div class="row right">
		<button class="write-btn input input-inline btn btn-info">글쓰기</button>
	</div>
	
	<!-- 페이지 네비게이션 -->
	<div class="btn-box row center">
		<div class="row">
			<ul class="pagination">
			<%if(isSearch) {%>
				<li class="remove-hover-style"><a href="list.jsp?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
			<%}else { %>
				<li class="remove-hover-style"><a href="list.jsp?p=<%=startBlock-1%>">&lt;</a></li>
			<%} %>
			<%for(int i =startBlock; i<=endBlock; i++){ %>
				<li class="remove-hover-style">
				<%if(isSearch){ %>
					<!-- 검색용 링크 -->
					<a href="list.jsp?p=<%=1%>&type=<%=type%>&key=<%=key%>"><%=i%></a>
				<%}else{ %>
					<!-- 목록용 링크 -->
					<a href="list.jsp?p=<%=i%>"><%=i%></a>
				<%} %>
				</li>
			<%} %>
			
			<%if(isSearch){ %>
				<li class="remove-hover-style"><a href="list.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
			<%}else{ %>
				<li class="remove-hover-style"><a href="list.jsp?p=<%=endBlock+1%>">&gt;</a></li>
			<%} %>
		</ul>
		</div>
	</div>
	
	<!-- 검색창  -->
	<form action="list.jsp" method="post" class="form-inline">
	<div class="row center">
		<select name="type" class="input input-inline form-control">
			<option value="board_title" <%if(type!=null&&type.equals("board_title")){%>selected<%}%>>제목</option>
			<option value="board_writer" <%if(type!=null&&type.equals("board_writer")){%>selected<%}%>>작성자</option>
		</select>
		<%if(isSearch){ %>
		<input type="text" class="input input-inline form-control" name="key" required value="<%=key%>">
		<%}else{ %>
		<input type="text" class="input input-inline form-control" name="key" required>
		<%} %>
		<input type="submit" class="btn btn-info" value="검색">
	</div>
	</form>
	
<jsp:include page="/template/footer.jsp"></jsp:include>