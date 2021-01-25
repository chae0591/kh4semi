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
	int member_no;
	boolean isMember;
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto;

	try{
		//로그인한 회원이면
		member_no = (int)session.getAttribute("check");
		memberDto = memberDao.find(member_no);
		isMember = memberDto.getMember_id().equals(boardDto.getBoard_writer());
	}catch(Exception e) {
		//로그인 안했다면
		isMember = false;
	}
%>
<%
	//댓글 목록 구하기
	QnaOpinionDao opinionDao = new QnaOpinionDao();
	List<QnaOpinionDto> opinionList = opinionDao.select(board_no);
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
</style>
<script>
	$(function(){
		//수정버튼 -> edit.jsp
		$(".edit-btn").click(function(){
			location.href = "edit.jsp?board_no=<%=board_no%>";//절대경로
		});
		
		//삭제버튼 -> delete.do
		$(".delete-btn").click(function(){
			location.href = "delete.do?board_no=<%=board_no%>";//절대경로
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
			<li><a href="/semi/qna_board/list.jsp">목록으로</a></li>
		</ul>
	</div>
	
	<div class="article">
		<table>
			<tbody>
			<!-- 게시글 -->
				<tr>
					<td><%=boardDto.getBoard_writer()%><%=boardDto.getRegist_time()%></td>
				</tr>
			
				<tr>
					<td><p>질문</p><%=boardDto.getBoard_title()%></h4></td>
				</tr>
			
				<tr>
					<td><%=boardDto.getBoard_content()%></td>
				</tr>
			
				<tr>
					<td>좋아요<%=boardDto.getVote() %></td>
				</tr>
			
			<!-- 댓글 목록 -->	
				<tr>
					<td>
						<div class="opinion-box">
							<%for(QnaOpinionDto opinionDto : opinionList){ %>
								<div><%=opinionDto.getOpinion_writer()%></div>
								<div><%=opinionDto.getOpinion_content()%></div>
								<div>
									<% 
										SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd h:mm:ss");
										String timeFormat = f.format(opinionDto.getRegist_time());
									%>
									<%=timeFormat%>
								</div>
							<%} %>
						</div>
					</td>
				</tr>
				
				<!-- 댓글 작성란 -->
				<tr>
					<td>
						<div>
							<form action="opinion_write.do" method="post">
								<input type="hidden" name="board_no" value="<%=board_no%>">
								<div>
									<textarea class="input" name="opinion_content" required rows="5" placeholder="댓글 작성"></textarea>
								</div>
								<div>
									<input type="submit" value="댓글 작성" class="input">
								</div>
							</form>
						</div>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<!-- 로그인한 회원만 볼 수 있도록 구현 -->	
				<%if(isMember){ %>
					<button class="input edit-btn">수정</button>
					<button class="input delete-btn">삭제</button>
				<%} %>
			</tfoot>
		</table>
		
	</div>


<jsp:include page="/template/footer.jsp"></jsp:include>