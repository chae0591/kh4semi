<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>

<%
	QnaBoardDao dao = new QnaBoardDao();
	List<QnaBoardDto> list = dao.select();
	
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
	
	if(isSearch) {
		list= dao.pagingList(type, key, startRow, endRow);
	}
	else {
		list = dao.pagingList(startRow, endRow);
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
		height: 560px;
	}
	.aside li{
		list-style: none;
	}
	.article {
		border: 1px solid black;
		float: right;
		width: 80%;
		height: 560px;
	}
	.pagination {
		text-align: center;
		width: 100%;
	}
	
	.pagination > ul> li {
		display: inline-block;
		text-decoration: none;
	}
	table {
		width: 100%;
		border-collapse: collapse;
		table-layout:fixed; 
	}
	thead{
		text-align:center;
	}
	td {
		text-overflow:ellipsis; 
		overflow:hidden; 
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
	/* .regist_time {
		position: absolute;
   	 	top: 20px;
    	right: 20px;
    	line-height: 1.4;
    	font-size: 12px;
	} */
	.tb-top {
		border-top: 1px solid black;
	}
	.tb-bottom {
		border-bottom: 1px solid black;
	}
	.font-bold {
		font-weight: bold; 
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
	<div class="aside">
		<ul>
			<li><a href="#">최신순</a></li>
			<li><a href="#">댓글순</a></li>
		</ul>
	</div>
	
	<div class="article">
	<div class="row">
	<!— margin-right: 525px —>
		<table class="table"> 
			<thead>
				<tr>
					<th>답변을 기다려요! </th>
				</tr>
			</thead>
			<tbody class="">
				<%for(QnaBoardDto dto : list){ %>
					<tr>
						<td class="left tb-top">
							<nobr>
								<div class="board_title">
									<a href="detail.jsp?board_no=<%=dto.getBoard_no()%>" style="float: left">
									<span>[질문]</span><span><%=dto.getBoard_title()%></span></a>
								
								</div>					
							</nobr>
						</td>
					</tr>
					<tr class="">
						<td class="left">
							<nobr>
								<a href="detail.jsp?board_no=<%=dto.getBoard_no()%>">
									<%=dto.getBoard_content()%>
								</a>
							</nobr>
						</td>
					</tr>
					<tr>
						<td class="left tb-bottom">
							<div>
								<span class="font-bold"><%=dto.getBoard_writer()%></span><span>님의 질문입니다</span>
								<span style="float: right"><%=dto.getRegist_time()%></span>
							</div>
						
						</td>	
					</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
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