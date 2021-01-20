<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="beans.*" %>


<%
	request.setCharacterEncoding("UTF-8");
%>

<%
// 	페이지 분할 계산 코드를 작성
	int boardSize = 10;

// 	int p = Integer.parseInt(request.getParameter("p")) or 1;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();//강제예외
	}
	catch(Exception e){
		p = 1;
	}
	
// 	p의 값에 따라 시작 row번호와 종료 row번호를 계산
	int endRow = p * boardSize;
	int startRow = endRow - boardSize + 1;
%>

<h1>p = <%=p%>, startRow = <%=startRow%>, endRow = <%=endRow%></h1>




<%
	// 	목록,검색을 위해 필요한 프로그래밍 코드
// 	type : 분류 , key : 검색어
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	boolean isSearch = type != null && key != null;

	TipBoardDao dao = new TipBoardDao();
	List<TipBoardOpinionCountVO> list; 
	if(isSearch){
		list = dao.pagingReplyCountList(type, key, startRow, endRow);  
	}
	else{
		list = dao.pagingReplyCountList(startRow, endRow); 
	}

	//TipBoardDao dao = new TipBoardDao();
	//List<TipBoardDto> list; 
	//list = dao.select();
%>   

<%
// 	페이지 네비게이터 계산 코드를 작성
	
// 	블록 크기를 설정
	int blockSize = 10;

// 	페이지 번호에 따라 시작블록과 종료블럭을 계산
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
// 	endBlock이 마지막 페이지 번호보다 크면 안된다 = 데이터베이스에서 게시글 수를 구해와야 한다.
// 	int count = 목록개수 or 검색개수;
	int count;
	if(isSearch){
		count = dao.getCount(type, key); 
	}
	else{
		count = dao.getCount();
	}

// 	페이지 개수 = (게시글수 + 9) / 10 = (게시글수 + 페이지크기 - 1) / 페이지크기
	int pageSize = (count + boardSize - 1) / boardSize;
	
	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>


<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	$(function(){
		//.write-btn을 누르면 글쓰기 페이지로 이동
		$(".write-btn").click(function(){
			//상대경로
			//location.href = "write.jsp";
			//$(location).attr("href", "write.jsp");
			
			//절대경로
			//location.href = "http://localhost:8888/home/board/write.jsp";
			//location.href = "/home/board/write.jsp";
			location.href = "<%=request.getContextPath()%>/tip_board/write.jsp";
		});
	});
</script>

<div class="outbox" style="width:640px">
	<div class="row center">
		<h2>환영합니다!</h2>
		<%for(TipBoardOpinionCountVO dto : list){ %>
		<div>
			
			<!-- 글 제목을 누르면 상세 페이지로 이동하도록 번호를 첨부하여 링크 설정 -->		
			<a href="detail.jsp?board_no=<%=dto.getBoard_no()%>">				
				<%=dto.getBoard_title()%>
			</a>
			<!-- 댓글 개수 출력(있을 경우만) -->
			<%if(dto.getOpinion_count() > 0){ %>
				[<%=dto.getOpinion_count()%>]
			<%}%>
			
		</div>
		<%} %>
	</div>
	
	<div class="row right">
		<button class="write-btn input input-inline">글쓰기</button>
	</div>
	
	<!-- 검색창 -->
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
	
	<!-- 페이지 네비게이션 -->
	<div class="row">
		<ul class="pagination">
			<%if(isSearch){ %>
				<li><a href="list.jsp?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
			<%}else{ %>
				<li><a href="list.jsp?p=<%=startBlock-1%>">&lt;</a></li>
			<%} %>
			
			<%for(int i=startBlock; i<=endBlock; i++){ %>
				<%if(i == p){ %>
				<li class="active">
				<%}else{ %>
				<li>
				<%} %>
				<%if(isSearch){ %>
					<!-- 검색용 링크 -->
					<a href="list.jsp?p=<%=i%>&type=<%=type%>&key=<%=key%>"><%=i%></a>
				<%}else{ %>
					<!-- 목록용 링크 -->
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
</div>
			
<jsp:include page="/template/footer.jsp"></jsp:include>		
		