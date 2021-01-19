<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>
<%@ page import="java.util.*" %>
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
	auth = (String)session.getAttribute("auth");
	boolean isAdmin = false;
	if(auth != null) isAdmin = auth.equals("관리자");
	
	//int member_no = (int)session.getAttribute("check");
	String member_nick;
	member_nick = (String)session.getAttribute("check");
	boolean isOwner = false;
	MemberDto memberDto = null;
	if(member_nick != null){
		memberDto = memberDao.find(member_nick);
		isOwner = memberDto.getMember_id().equals(boardDto.getBoard_writer());
	}
%>

<%
	/////////////////////////////////////////////////////////////////
	//  댓글 목록 구하는 코드
	//	= 모든 댓글을 보는 경우는 없음 = 게시글별로 보는 경우만 존재 = 작성순으로 정렬
	//	= select * from reply where reply_origin = ? order by reply_no asc
	/////////////////////////////////////////////////////////////////
	TipOpinionDao tipOpinionDao = new TipOpinionDao();
	List<TipOpinionDto> tipOpList = tipOpinionDao.select(board_no); 
%>
    
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
				//location.href = "<%=request.getContextPath()%>/tip_board/delete.do?board_no=<%=board_no%>";
			}
		});
		
		//목록 버튼을 누르면 list.jsp로 보낸다
		$(".list-btn").click(function(){
			//location.href = "list.jsp";//상대경로
			location.href = "<%=request.getContextPath()%>/tip_board/list.jsp";//절대경로
		});
		
		
		//댓글관련 처리
		//1. 최초에 수정화면(.reply-edit)를 숨김 처리
		$(".reply-edit").hide();
		
		//2. 수정버튼(.reply-edit-btn)을 누르면 일반화면(.reply-normal)을 숨기고 수정화면(.reply-edit)을 표시
		// = a태그이므로 기본이벤트를 차단해야한다
		$(".reply-edit-btn").click(function(e){
			e.preventDefault();
			
			//this를 기준으로 dom 탐색을 수행(this == 링크 버튼)
			//$(this).parent().parent().hide();
			//$(this).parent().parent().next().show();
			$(this).parents(".reply-normal").hide();
			$(this).parents(".reply-normal").next().show();
		});
		
		//3. 작성 취소 버튼(.reply-edit-cancel-btn)을 누르면 수정화면을 숨기고 일반화면을 표시한다.
		$(".reply-edit-cancel-btn").click(function(){
			//$(this).parent().parent().parent().hide();
			//$(this).parent().parent().parent().prev().show();
			$(this).parents(".reply-edit").hide();
			$(this).parents(".reply-edit").prev().show();
		});
	});
</script>

<div class="outbox" style="width:640px;">
	<div class="row center">
		<h2>
			<%=boardDto.getBoard_no()%>번 게시글
		</h2>
	</div>
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th class="right" colspan="2">
						<button class="input input-inline write-btn">새글</button>
						<%if(isOwner || isAdmin){ %>
						<!-- 수정과 삭제 버튼은 작성자 본인과 관리자에게만 표시되어야 한다 -->
						<button class="input input-inline edit-btn">수정</button>
						<button class="input input-inline delete-btn">삭제</button>
						<%} %>
						<button class="input input-inline list-btn">목록</button>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>작성자</th>
					<td class="left"><%=boardDto.getBoard_writer()%></td>
				</tr>
				<tr>
					<th width="20%">제목</th>
					<td class="left"><%=boardDto.getBoard_title()%></td>
				</tr>
				<tr height="200">
					<th>내용</th>
					<td class="left" valign="top"><%=boardDto.getBoard_content()%></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td class="left"><%=boardDto.getRegist_time()%></td>
				</tr>
				
				<!-- 댓글 목록 -->
				<tr>
					<td colspan="2">
						
						<div class="outbox">
							
							<%for(TipOpinionDto tipOpDto : tipOpList){ %>
							
							<!-- 일반 출력 화면 -->
							<div class="row left reply-normal">
								<div>
									<%=tipOpDto.getOpinion_writer()%>
									
									<%if(boardDto.getBoard_writer().equals(tipOpDto.getOpinion_writer())){ %>
										<span style="color:red;">(작성자)</span>
									<%} %>
								</div>
								<div><%=tipOpDto.getOpinion_text()%></div>
								<div>
									<%
										SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd E a h:mm:ss");
										String timeFormat = f.format(tipOpDto.getRegist_time());
									%>
									<%=timeFormat%>
									
									<!-- 수정은 본인만, 삭제는 본인과 관리자만 -->
									<%
										boolean isReplyOwner = false;
										if(memberDto != null)
											isReplyOwner = memberDto.getMember_id().equals(tipOpDto.getOpinion_writer());
									%>
									<%if(isReplyOwner){ %>
									<a href="#" class="reply-edit-btn">수정</a> |
									<%} %>
									
									<%if(isAdmin || isReplyOwner){ %>
									<a href="opinion_delete.do?opinion_no=<%=tipOpDto.getOpinion_no()%>&board_no=<%=board_no%>">삭제</a>
									<%} %>
								</div>
							</div>
							
							<%if(isReplyOwner){ %>
							<!-- 수정을 위한 화면 : 본인에게만 나오도록 조건을 설정 -->
							<div class="row left reply-edit">
								<form action="opinion_edit.do" method="post">
									<input type="hidden" name="opinion_no" value="<%=tipOpDto.getOpinion_no()%>">
									<input type="hidden" name="board_no" value="<%=board_no%>">
									<div class="row">
										<textarea class="input" name="opinion_text" required rows="5" 
											placeholder="댓글 작성"><%=tipOpDto.getOpinion_text()%></textarea>
									</div>
									<div class="row">
										<input type="submit" value="댓글 수정" class="input input-inline">
										<input type="button" value="작성 취소" class="input input-inline reply-edit-cancel-btn">
									</div>
								</form>
							</div>
							<%} %>
							
							<%} %>
							
						</div>
						
									
					</td>
				</tr>
				
				<!-- 댓글 작성란 -->
				<tr>
					<td colspan="2">
					
						<!-- 댓글 등록 form -->
						<form action="opinion_insert.do" method="post">
							<input type="hidden" name="board_no" value="<%=board_no%>">
							<div class="row">
								<textarea class="input" name=opinion_text required rows="5" placeholder="댓글 작성"></textarea>
							</div>
							<div class="row">
								<input type="submit" value="댓글 작성" class="input">
							</div>
						</form>
					</td>
				</tr>
				
			</tbody>
			<tfoot>
				<tr>
					<th class="right" colspan="2">
						<button class="input input-inline write-btn">새글</button>
						
						<%if(isOwner || isAdmin){ %>
						<!-- 수정과 삭제 버튼은 작성자 본인과 관리자에게만 표시되어야 한다 -->
						<button class="input input-inline edit-btn">수정</button>
						<button class="input input-inline delete-btn">삭제</button>
						<%} %>
						<button class="input input-inline list-btn">목록</button>
					</th>
				</tr>
			</tfoot>			
		</table>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>