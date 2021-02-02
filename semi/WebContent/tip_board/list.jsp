<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="beans.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
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
<%
	int orderColumn;
	int orderType;
	try{
		orderColumn = Integer.parseInt(request.getParameter("orderColumn"));
	}
	catch(Exception e){
		orderColumn = 0;
	}
	try{
		orderType= Integer.parseInt(request.getParameter("orderType"));
	}
	catch(Exception e){
		orderType = 0;
	}
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	boolean isSearch = type != null && key != null;
	TipBoardDao dao = new TipBoardDao();
	List<TipBoardOpinionCountVO> list; 
	if(isSearch){
		list = dao.orderedPagingReplyCountList(orderColumn, orderType, type, key, startRow, endRow);  
	}
	else{
		list = dao.orderedPagingReplyCountList(orderColumn, orderType, startRow, endRow); 
	}
%>   
<%
	int blockSize = 10;
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	int count;
	if(isSearch){
		count = dao.getCount(type, key); 
	}
	else{
		count = dao.getCount();
	}
	int pageSize = (count + boardSize - 1) / boardSize;
	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>
<style>
	.v-center{
		 vertical-align: middle;
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
	.container-content {
		padding: 10px;
	}
	.gray {
		color: #999;
	}
	.black {
		color: #000;
	}
	.white {
		color: #fff;
	}

	.border-gray-1 {
		border: 1px solid #999 !important;
  		border-radius: 10px;
	}
	div{ box-sizing: border-box; }
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
    .btn-more{
    	padding: 0 35px;
    	height: 35px;
    	line-height: 35px;
    	border: 1px solid #ddd;
    	border-radius: 2px;
    	font-size: 14px;
    	color: #333;
    	border-radius: 10px;
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
    	width:200px;
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
	.vote, .heart, .reply, .opinion{
		font-size: 14px;
    	line-height: 24px;
    	font-weight: 300;
    	color: #8c8c8c;
	}    
    
</style>
<jsp:include page="/template/header.jsp"></jsp:include>
<script>
	function setUrlParam(key, value){
		var urlParams = new URLSearchParams(window.location.search);
		urlParams.set(key, value);
		window.location.search = urlParams;
	}
	function setUrlParamByArr(arr){
		var urlParams = new URLSearchParams(window.location.search);
		arr.map(function(el){
			var key = el[0];
			var value = el[1];
			urlParams.set(key, value);
		});
		window.location.search = urlParams;
	}
	$(function(){
		$(".write-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/tip_board/write.jsp";
		});
	});
</script>
<div class="contents left">
	<a href="<%=request.getContextPath()%>">전체</a>
	<span> &gt; </span> 
	<a href="<%=request.getContextPath()%>/tip_board/list.jsp">여행꿀팁</a>
</div>

<div class="bigTitle">여행꿀팁</div>
<div class="btn-box ">
	<a class="gray <%if(orderColumn == 0){%> black <%} %>"
		href="#" onclick="setUrlParamByArr([['p','1'],['orderColumn', '0']]); return false;">최신순</a>
	<a class="gray <%if(orderColumn == 1){%> black <%} %>"
		href="#" onclick="setUrlParamByArr([['p','1'],['orderColumn', '1']]); return false;">댓글순</a>
</div>
<div class="container-tip">
  	<%for(TipBoardOpinionCountVO dto : list){ %>
	<div class="item border-gray-1">
  		<a href="<%=request.getContextPath()%>/tip_board/detail.jsp?board_no=<%=dto.getBoard_no()%>">
			<span style="float:left; color:blue;">Tip</span>
			<span class="title-line"><%=dto.getBoard_title() %></span>
			<%-- <%if(dto.getOpinion_count() > 0){ %>
				[<%=dto.getOpinion_count()%>]
			<%}%> --%>
			<!-- 좋아요 -->
			<span class="heart">♡</span><span class="vote"><%=dto.getVote()%></span>
			<!-- 댓글개수 -->
			<span class="reply">댓글</span><span class="opinion"><%=dto.getOpinion_count()%></span>
			
			<span class="right-line"><%=dto.getRegist_time() %></span>
			<br><br>
			<span class="content-line" style="margin-left: 2.5rem"><%=dto.getBoard_content()%></span>
			<br>
			<span style="float:left; font-size:14px; margin-left: 2.5rem;">일정 <%=dto.getStart_date()%> ~ <%=dto.getEnd_date() %></span>
			<span class="right-line" style="color:#8C8C8C"><%=dto.getMember_nick() %> 여행작가</span>
		</a>
	</div>
	<%} %>
</div>
<div class="btn-box row right">
	<button class="write-btn input input-inline btn btn-info">글쓰기</button>
</div>
<div class="btn-box row center">
	<div class="row">
		<ul class="pagination">
			<li 
				<%if(startBlock == 1){%>
					class="remove-hover-style"
				<%}else{%>
					onclick="setUrlParam('p', '<%=startBlock-1%>');"
				<%}%>>&lt;
			</li>
			<%for(int i=startBlock; i<=endBlock; i++){ %>
				<li 
					class="<%if(i == p){%> active <%}%>"
					onclick="setUrlParam('p', '<%=i%>');"><%=i%>
				</li>
			<%} %>
			<li 
				<%if(endBlock == pageSize){%>
					class="remove-hover-style"
				<%}else{%>
					onclick="setUrlParam('p', '<%=endBlock+1%>');"
				<%}%>>&gt;
			</li>
		</ul>
	</div>
</div>


<form class="form-inline" action="list.jsp" method="get">
<div class="row center">
	<select name="type" class="input input-inline v-center form-control" style="vertical-align: middle;">
		<option value="board_title" <%if(type!=null&&type.equals("board_title")){%>selected<%}%>>제목</option>
		<option value="board_writer" <%if(type!=null&&type.equals("board_writer")){%>selected<%}%>>작성자</option>
	</select>
	<%if(isSearch){ %>
	<input type="text" class="input input-inline v-center form-control" name="key" required value="<%=key%>">
	<%}else{ %>
	<input type="text" class="input input-inline v-center form-control" name="key" required>
	<%} %>
	<input type="submit" class="btn btn-info" value="검색">
</div>
</form>
<jsp:include page="/template/footer.jsp"></jsp:include>		
		