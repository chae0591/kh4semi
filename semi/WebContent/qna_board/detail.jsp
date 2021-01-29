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

<h1>count = <%=count%>, Size = <%=pageSize%>, startBlock = <%=startBlock%>, endBlock = <%=endBlock%></h1>
<jsp:include page="/template/header.jsp"></jsp:include>
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
	.all-content-box {
		width: 100%;
		margin-bottom: 10px;
	}
	.text-box {
		margin-bottom: 10px;
		padding: 0.5rem;
	}
	.opinion-input-box {
		width: 100%;
		border: 1px solid black;
		border-radius: 6px;
	}
	.opinion-input-box > .content-box {
		outline: none;
	}
	.opinion-input-box > .input-btn {
		float: right;
		display: block;
	}
	.opinion-list-box {
		width: 100%;
	}
	.opinion-list-box > .opinion-normal {
		width: 100%;
		border: 1px solid black;
		margin-bottom: 10px;
		padding: 0.5rem;
	}
</style>
<script>
	$(function(){
		//글쓰기버튼 -> write.jsp
		$(".write-btn").click(function(){
			location.href = "write.jsp";
		});
		
		//수정버튼 -> edit.jsp
		$(".edit-btn").click(function(){
			location.href = "edit.jsp?board_no=<%=board_no%>";//절대경로
		});
		
		//삭제버튼 -> delete.do
		$(".delete-btn").click(function(){
			location.href = "delete.do?board_no=<%=board_no%>";//절대경로
		});
		
		//좋아요 버튼 -> vote_write_delete.do
		$(".vote-btn").click(function(){
			location.href = "vote_write_delete.do?board_no=<%=board_no%>";//절대경로
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
	<div>
		<a href="/semi">전체</a>
		<span> > </span>
		<a href="/semi/qna_board/list.jsp">여행Q&A</a>
	</div>
	
	
	<div class="outbox">
	<!-- 목록으로 -->
	<aside>
		<ul>
			<li><a href="/semi/qna_board/list.jsp">목록으로</a></li>
		</ul>
	</aside>
	
	<article>
		<table class="table-box">
			<tbody>
			<!-- 게시글 -->
				<tr>
					<td>
						<div class="all-content-box">
						<div class="text-box">
							<p><%=boardDto.getBoard_writer()%><%=boardDto.getRegist_time()%></p>
					
							<span>질문</span><span><%=boardDto.getBoard_title()%></span>
					
							<p><%=boardDto.getBoard_content()%></p>
						
							<span class="vote">좋아요</span><span><%=boardDto.getVote()%></span>
						</div>
			<!-- 댓글 작성란 -->
						<div class="opinion-box">
							<form action="opinion_write.do" method="post">
							<div class="row">
								<input type="hidden" name="board_no" value="<%=board_no%>">
							</div>
							<div class="row opinion-input-box">
								<textarea class="input content-box" name="opinion_content" style="border:none" required rows="5" placeholder="댓글을 작성해주세요(최대 80자)"></textarea>
							</div>
							<div class="row input-btn">
								<input type="submit" value="댓글 등록" class="input">
							</div>
							</form>
						</div>
						</div>
					</td>
				</tr>
					
				
			<!-- 댓글 목록 -->	
				<tr>
					<td>
						<div class="opinion-list-box">
							<%for(QnaOpinionDto opinionDto : list){ %>
							
							<!-- 일반 출력 화면 -->
							<div class="opinion-normal">
								<div><%=opinionDto.getOpinion_writer()%></div>
									<%if(boardDto.getBoard_writer().equals(opinionDto.getOpinion_writer())){ %>
										<span style="color:red;">(작성자)</span>
									<%} %>
								<div><%=opinionDto.getOpinion_content()%></div>
								<div>
									<% 
										SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd E a h:mm:ss");
										String timeFormat = f.format(opinionDto.getRegist_time());
									%>
									<%=timeFormat%>
								</div>
								<div>	
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
									<a href="#" class="opinion-edit-btn">수정</a> |
									<%} %>
									
									<%if(isReplyWriter || isMember){ %>
									<a href="opinion_delete.do?opinion_no=<%=opinionDto.getOpinion_no()%>&board_no=<%=board_no%>" class="opinion-delete-btn">삭제</a>
									<%} %>
								</div>
							</div>
							
							<!-- 수정을 위한 화면 : 댓글 작성자에게만 나오도록 조건 설정 -->
							<%if(isReplyWriter){ %>
							<div class="opinion-edit">
								<form action="opinion_write.do" method="post">
									<input type="hidden" name="opinion_no" value="<%=opinionDto.getOpinion_no()%>">
									<input type="hidden" name="board_no" value="<%=board_no%>">
									<div class="row">
										<textarea class="input" name="opinion_content" required rows="5" 
											placeholder="댓글 작성"><%=opinionDto.getOpinion_content()%></textarea>
									</div>
									<div class="row">
										<input type="submit" value="댓글 수정" class="input input-inline opinion-re-edit-btn">
										<input type="button" value="작성 취소" class="input input-inline opinion-edit-cancel-btn">
									</div>
								</form>
							</div>
							<%} %>
							<%} %>
						</div>
						
						<!-- 페이지 네비게이션 -->
						<div class="row">
							<ul class="pagination center">
							
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
					</td>
				</tr>
				
			</tbody>
			<tfoot>
			
				<tr>
					<th>
					<!-- 로그인한 회원만 볼 수 있도록 구현 -->	
					<%if(isMember){ %>
						<button class="vote-btn">좋아요</button>
						<button class="write-btn">글쓰기</button>
						<button class="edit-btn">수정</button>
						<button class="delete-btn">삭제</button>
					<%} %>
					</th>
				</tr>
				
			</tfoot>
		</table>
		
	</article>
	</div>


<jsp:include page="/template/footer.jsp"></jsp:include>