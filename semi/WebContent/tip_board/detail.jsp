<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="beans.*"%>
<%@ page import="java.util.*"%>
<%
	/////////////////////////////////////////////////////////////////
	//  게시글 구하는 코드
	/////////////////////////////////////////////////////////////////

	//1.번호를 받는다
	int board_no = Integer.parseInt(request.getParameter("board_no"));

	//2.조회수를 증가시킨 후 게시글 정보를 구한다
	TipBoardDao boardDao = new TipBoardDao();
	TipBoardDto boardDto = boardDao.find(board_no);

	//참고 : 작성자의 다른 정보가 필요할 경우 검색한다.
	MemberDao memberDao = new MemberDao();
	MemberDto writerDto = memberDao.find(boardDto.getBoard_writer());

	//3.화면에 출력한다

	//작성자 본인 또는 관리자인지 파악하기 위한 검사코드
	//- 관리자 : 세션에 auth 항목을 조사하여 관리자인지 확인
	//- 본인 : 로그인한 사용자의 ID와 게시글의 작성자가 같은지 확인
	String auth;
	auth = (String) session.getAttribute("auth");
	boolean isAdmin = false;
	if (auth != null)
		isAdmin = auth.equals("관리자");

	//int member_no = (int)session.getAttribute("check");
	int member_no;
	boolean isOwner;
	MemberDto memberDto = null;

	try {
		member_no = (int) session.getAttribute("check");
		memberDto = memberDao.find(member_no);
		isOwner = memberDto.getMember_id().equals(boardDto.getBoard_writer());
	} catch (Exception e) {
		isOwner = false;
	}
%>

<%
	/////////////////////////////////////////////////////////////////
	//  댓글 목록 구하는 코드
	//	= 모든 댓글을 보는 경우는 없음 = 게시글별로 보는 경우만 존재 = 작성순으로 정렬
	//	= select * from reply where reply_origin = ? order by reply_no asc
	/////////////////////////////////////////////////////////////////
	TipOpinionDao tipOpinionDao = new TipOpinionDao();
	TipOpinionDto opinionDto = new TipOpinionDto();
	List<TipOpinionDto> tipOpList = tipOpinionDao.select(board_no);
%>

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
.container-content {
	padding: 10px;
}

.gray {
	color: #999;
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

.float-box::after {
	content: "";
	display: block;
	clear: both;
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

.aside {
	border: 1px solid black;
	float: left;
	width: 20%;
}

.aside li {
	list-style: none;
}

.article {
	border: 1px solid black;
	float: right;
	width: 80%;
}

.pagination {
	text-align: center;
	width: 100%;
}

.pagination>ul>li {
	display: inline-block;
	text-decoration: none;
}

table {
	border-collapse: collapse;
	table-layout: fixed;
}

thead {
	text-align: center;
}

td {
	text-overflow: ellipsis;
	overflow: hidden;
}

.board_title {
	width: 100%;
	height: 20px;
	text-overflow: ellipsis;
	overflow: hidden;
}

.board_title>a {
	width: 100%;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
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
	//각종 버튼들을 누르면 해당 위치로 이동하도록 구문을 작성
	$(function(){
		//새글 버튼을 누르면 write.jsp로 보낸다
		$(".write-btn").click(function(){
			//location.href = "write.jsp";//상대경로
			location.href = "<%=request.getContextPath()%>/tip_board/write.jsp";//절대경로
		});
		
		//수정 버튼을 누르면 edit.jsp로 번호를 첨부하여 보낸다
		$(".edit-btn").click(function(){
			location.href = "edit.jsp?board_no=<%=board_no%>";
		});
		
		//삭제 버튼을 누르면 확인창을 띄우고 확인을 누르면 삭제 페이지에 번호를 첨부하여 보낸다
		$(".delete-btn").click(function(){
			if(confirm("정말 지우시겠습니까?")){
				location.href = "delete.do?board_no=<%=board_no%>";
			}
		});

		//목록 버튼을 누르면 list.jsp로 보낸다
		$(".vote-btn").click(function(){
			location.href = "vote_insert_delete.do?board_no=<%=board_no%>";
		});
		
		//목록 버튼을 누르면 list.jsp로 보낸다
		$(".list-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/tip_board/list.jsp";//절대경로
		});

		//댓글관련 처리
		//1. 최초에 수정화면(.reply-edit)를 숨김 처리
		$(".reply-edit").hide();

		//2. 수정버튼(.reply-edit-btn)을 누르면 일반화면(.reply-normal)을 숨기고 수정화면(.reply-edit)을 표시
		// = a태그이므로 기본이벤트를 차단해야한다
		$(".reply-edit-btn").click(function(e) {
			e.preventDefault();
			//this를 기준으로 dom 탐색을 수행(this == 링크 버튼)
			//$(this).parent().parent().hide();
			//$(this).parent().parent().next().show();
			$(this).parents(".reply-normal").hide();
			$(this).parents(".reply-normal").next().show();
		});

		//3. 작성 취소 버튼(.reply-edit-cancel-btn)을 누르면 수정화면을 숨기고 일반화면을 표시한다.
		$(".reply-edit-cancel-btn").click(function() {
			//$(this).parent().parent().parent().hide();
			//$(this).parent().parent().parent().prev().show();
			$(this).parents(".reply-edit").hide();
			$(this).parents(".reply-edit").prev().show();
		});
		
		//삭제버튼 -> opinion_delete.do
		$(".opinion-delete-btn").click(function(){
			if(confirm("정말 지우시겠습니까?")){
				location.href = "opinion_delete.do?opinion_no=<%=opinionDto.getOpinion_no()%>&board_no=<%=board_no%>";//절대경로
			}
		});
	});
</script>

<div class="gray">
	<a class="gray" href="/semi">전체</a> <span> &gt; </span> 
	<a class="gray" href="/semi/qna_board/list.jsp">여행꿀팁</a>
</div>

<hr>
<div class="float-box ">

	<div class="aside">
		<div class="container-content center">
			<div class="padding-top-20"> 
				<img src="https://placeimg.com/100/100/summer" alt="Avatar" style="border-radius: 50%">
			</div>
			<br>
			<h3>
				<%
				MemberDto memberDtoByBoardNo = new MemberDto();
				memberDtoByBoardNo = memberDao.find(boardDto.getBoard_writer()); 
				%>
				<%=memberDtoByBoardNo.getMember_nick()%>
			</h3>
			<div class="gray">여행작가</div>
			<div>
				<a class="gray"
					href="list.jsp?type=board_writer&key=<%=boardDto.getBoard_writer()%>">
					작성글 (<%=boardDao.getCount("board_writer", boardDto.getBoard_writer())%>)
				</a>
			</div>
		</div>
	</div>

	<div class="article">
		<div class="row">

			<div class="container-content">
				<h3> <%=boardDto.getBoard_title()%>
				</h3>

				<div style="color: #999;">
					<div>
						여행시작일 :
						<%=boardDto.getStart_date()%>
						여행종료일 :
						<%=boardDto.getEnd_date()%></div>
					<div>
						작성일 :
						<%=boardDto.getRegist_time()%></div>
				</div>

			</div>

			<hr>
			<div style="word-break: break-all;" class="container-content padding-top-20 padding-bottom-20 img-container"><%=boardDto.getBoard_content()%></div>


			<hr>
			<div class="container-content gray">
				
				<span class="btn input input-inline vote-btn">좋아요 (<%=boardDto.getVote()%>)</span>
			
				<span class="btn input input-inline write-btn">새글</span>
				<%
					if (isOwner || isAdmin) {
				%>
				<!-- 수정과 삭제 버튼은 작성자 본인과 관리자에게만 표시되어야 한다 -->
				<span class="btn input input-inline edit-btn">수정</span>
				<span class="btn input input-inline delete-btn">삭제</span>
				<%
					}
				%>
				<span class="btn input input-inline list-btn">목록</span>
			
			</div>

			<hr>
			
			<div class="container-content gray" >
				댓글 (<%=tipOpList.size()%>)
			</div>
			<form style="padding-left:10px;" action="opinion_insert.do" method="post">
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
			<div class="outbox container-content ">
				<%
					for(TipOpinionDto tipOpDto : tipOpList) {
				%>

				<!-- 일반 출력 화면 -->
				<div class="row left reply-normal padding-top-10">
					<div>
						<%=tipOpDto.getOpinion_writer()%>

						<%
							if (boardDto.getBoard_writer().equals(tipOpDto.getOpinion_writer())) {
						%>
						<span class="gray">(작성자)</span>
						
						<%
							}
						%>
						
						<%
							SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd h:mm:ss");
								String timeFormat = f.format(tipOpDto.getRegist_time());
						%>
						<span class="gray">
						 | <%=timeFormat%>
						</span>
						
						<%
							boolean isReplyOwner = false;
								if (memberDto != null)
									isReplyOwner = memberDto.getMember_id().equals(tipOpDto.getOpinion_writer());
						%>
						<%
							if (isReplyOwner) {
						%>
						<span class="gray"> | </span>
						<a href="#" class="reply-edit-btn gray">수정</a>
						<%
							}
						%>

						<%
							if (isAdmin || isReplyOwner) {
						%>
						<span class="gray"> | </span>
						<a class="opinion-delete-btn gray" href="opinion_delete.do?opinion_no=<%=tipOpDto.getOpinion_no()%>&board_no=<%=board_no%>">삭제</a>
						<%
							}
						%>
					</div>
					<div><%=tipOpDto.getOpinion_text()%></div>
					<div class="gray">
					</div>
				</div>

				<%
					if (isReplyOwner) {
				%>

				<!-- 수정을 위한 화면 : 본인에게만 나오도록 조건을 설정 -->
				<div class="row left reply-edit padding-top-20">
					<form action="opinion_edit.do" method="post">
						<input type="hidden" name="opinion_no"
							value="<%=tipOpDto.getOpinion_no()%>"> <input
							type="hidden" name="board_no" value="<%=board_no%>">
						<div class="row">
							<textarea class="input" name="opinion_text" required rows="5"
								placeholder="댓글 작성"><%=tipOpDto.getOpinion_text()%></textarea>
						</div>
						<div class="row">
							<input type="submit" value="댓글 수정" class="input input-inline">
							<input type="button" value="작성 취소"
								class="input input-inline reply-edit-cancel-btn">
						</div>
					</form>
				</div>
				<%
					}
				%>

				<%
					}
				%>

			</div>

	
	
		</div>

	</div>


</div>
