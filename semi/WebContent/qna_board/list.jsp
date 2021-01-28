<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>

<%
	//목록 가져오기
	QnaBoardDao dao = new QnaBoardDao();
	List<QnaBoardDto> list;
	
	//List<QnaBoardDto> list = dao.select();
	
	//page 
	int boardSize = 5;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e){
		p = 1;
	}
	
	int endRow = p * 5; 
	int startRow = endRow - boardSize + 1; 
	
	
%>
<h1> p = <%=p%>, startRow = <%=startRow%>, endRow = <%=endRow%></h1>

<%
	//목록 검색을 위해 필요한 프로그래밍 코드 
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean isSearch = type != null && key != null; 
	
	//목록 검색을 위해 필요한 프로그래밍 코드 
		/*
		
		if(isSearch) {
			list= dao.pagingList(type, key, startRow, endRow);
		}
		else {
			list = dao.pagingList(startRow, endRow);
		}
		*/

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
	//페이지 네비게이터 계산코드를 작성 
	
	//브록 크기를 설정 
	int blockSize = 10; 
	
	//페이지번호에 따라 시작블록과 종료블럭을 계산 
	int startBlock = (p-1)/ blockSize * blockSize + 1; 
	int endBlock = startBlock + blockSize -1; 
	//endBlock이 마지막 페이지 번호보다 크면 안된다 
	int count;
	if(isSearch) {
		count = dao.getCount(type, key);
	}else {
		count = dao.getCount(); 
	}
	
	int pageSize = (count + boardSize -1) / boardSize;
	 if(endBlock > pageSize) {
		endBlock = pageSize; 
	} 
%>
<style>
	.outbox {
		width:100%;
		height: auth;
		min-height: 700px;
		position: relative;
		border: 1px solid black;
		overflow: auto;
	}
	aside {
		border: 1px solid blue;
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
		border: 1px solid red;
		float: right;
		width: 80%;
		height: auth;
		min-height: 700px;
		padding: 1rem;
		position: relative;
	}
	.table-box {
		width: 100%;
		text-aligh: left;
	}
	.main-title{
		margin-bottom: 10px;
	}
	.text-box {
		margin-bottom: 10px;
		padding: 0.5rem;
		border: 1px solid black;
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

<jsp:include page="/template/header.jsp"></jsp:include>
<script>
$(function(){
	$(".write-btn").click(function(){
		location.href = "<%=request.getContextPath()%>/qna_board/write.jsp";
	});
});
</script>


	<!— 상단 부분 —>
	<div>
		<a href="/semi">전체</a>
		<span> > </span>
		<a href="/semi/qna_board/list.jsp">여행Q&A</a>
	</div>
	
	<!— 최신순, 댓글순 —>
	<aside>
		<ul>
		<%QnaBoardDto boardDto = new QnaBoardDto();%>
			<%if(isSearch){%>
				<li><a href="list.jsp?type=<%=type%>&key=<%=key%><">최신순</a></li>
			<%}else{ %>
				<li><a href="list.jsp">최신순</a></li>
			<%} %>
			<%if(isSearch){%>
				<li><a href="list.jsp?isOrder&type=<%=type%>&key=<%=key%><">댓글순</a></li>
			<%}else{ %>
				<li><a href="list.jsp?isOrder">댓글순</a></li>
			<%} %>
		</ul>
	</aside>
	
	<article>
		<table class="table-box"> 
		
			<thead>
				<tr>
					<th>
						<h4 class="main-title">답변을 기다려요!</h4>
					</th>
				</tr>
			</thead>
			
			<tbody>
				<%for(QnaBoardDto dto : list){ %>
				<tr>
					<td>
						<div class="text-box">
							<!-- 타이틀 -->
							<a href="detail.jsp?board_no=<%=dto.getBoard_no()%>" style="float: left">
								<span>[질문]</span><span><%=dto.getBoard_title()%></span></a>		
							<!-- 내용 -->				
							<a href="detail.jsp?board_no=<%=dto.getBoard_no()%>"><p><%=dto.getBoard_content()%></p></a>
							<!-- 작성자 -->
							<span><%=dto.getBoard_writer()%></span><span>님의 질문입니다</span>
							<!-- 작성날짜 -->
							<span><%=dto.getRegist_time()%></span>
							<!-- 좋아요 -->
							<span>♡</span><span><%=dto.getVote()%></span>
							<!-- 댓글개수 -->
							<span>댓글</span><span><%=dto.getOpinion()%></span>
						</div>
					</td>	
				</tr>
				<%} %>
			</tbody>
			
		</table>

	</article>
	
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
		<input type="submit" class="input input-inline" value="검색">
	</div>
	</form>
	
	
	<!— 페이지 네비게이션 —>
	<div class="row">
		<ul class="pagination">
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