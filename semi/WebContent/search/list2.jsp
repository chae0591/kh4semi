<%@page import="java.util.List"%>
<%@page import="beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String keyword = request.getParameter("keyword");
	
	//여행Q&A
	QnaBoardDao qnaboardDao = new QnaBoardDao();
	List<QnaSearchVO> qnaList = qnaboardDao.select(keyword);
	
	//여행꿀팁
	TipBoardDao tipboardDao = new TipBoardDao();
	List<TipSearchVO> tipList = tipboardDao.select(keyword);
%>
<!DOCTYPE html>
<style>
	div{ box-sizing: border-box; }
	
	.container{
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
		grid-auto-rows: minmax(7em, auto); 
		grdi-gap: 0.5rem;
		justify-items: start;
		align-items: start;		
	}
	.btn-more{
    	padding: 0 35px;
    	height: 35px;
    	line-height: 35px;
    	border: 1px solid #ddd;
    	border-radius: 2px;
    	font-size: 14px;
    	color: #333;
    }
   .col span{
   		margin-bottom: 0.5rem;
   }
   .item {
   		width: 100%;
   }
</style>


<jsp:include page="/template/header.jsp"></jsp:include>

<div>
	<h1>여행꿀팁</h1>
</div>

<hr size="3" color="black">

<%if(!tipList.isEmpty()){ %>
<div class="container">

	<%for(TipSearchVO tipsearchVO : tipList){ %>
	<div class="item">
		<table>
			<tbody>
				<tr class="col">
					<td><span class="left" style="color:red">질문 </span></td>
					<td><span class="left" style="font:bold"><%=tipsearchVO.getBoard_title()%></span></td>
				</tr>
				<tr class="col">
					<td colspan=2><span><%=tipsearchVO.getBoard_content()%></span></td>
				</tr>
				<tr class="col">
					<td colspan=2><span><%=tipsearchVO.getMember_nick()%>님의 작성글 입니다.</span></td>
				</tr>
				<tr class="col" class="right">
					<td colspan=2 class="right"><span><%=tipsearchVO.getRegist_time()%></span>					
				</tr>				
			</tbody>
		</table>
		<%-- <a href="<%=request.getContextPath()%>/tip_board/list.jsp?board_no=<%=tipsearchVO.getBoard_no()%>">
			<span style="color:red">질문 </span><span style="font:bold"><%=tipsearchVO.getBoard_title()%></span>
			<br>
			<span><%=tipsearchVO.getBoard_title()%></span>
			<br>
			<span><%=tipsearchVO.getMember_nick() %> 여행작가</span>
		</a> --%>
	</div>
	<%} %>
	
</div>

<div class="center">
	<a href="<%=request.getContextPath()%>/search/tiplist_more.jsp?keyword=<%=keyword%>" class="btn-more input">
		<span>여행꿀팁</span>
		<span>더보기&gt;</span>
	</a>
</div>

<%} else{%>
	<h3>'<%=keyword%>'에 대한 검색결과가 없습니다.</h3>
<%} %>

<div>
	<h1>여행Q&amp;A</h1>
</div>

<hr size="3" color="black">

<%if(!qnaList.isEmpty()){%>
<div class="container">

	<%for(QnaSearchVO qnasearchVO : qnaList){ %>
	<div class="item">
		<a href="<%=request.getContextPath()%>/qna_board/list.jsp?board_no=<%=qnasearchVO.getBoard_no()%>">
			<img src="https://placeimg.com/200/200/any" width="200" height="200"></img>
			<br>
			<span><%=qnasearchVO.getBoard_title()%></span>
			<br>
			<span><%=qnasearchVO.getMember_nick()%> 여행작가</span>
		</a>
	</div>
	<%} %>
	
</div>

	<div class="center">
		<a href="<%=request.getContextPath()%>/search/qnalist_more.jsp?keword=<%=keyword%>" class="btn-more input">
			<span>여행Q&amp;A</span>
			<span>더보기&gt;</span>
		</a>
	</div>

<%} else{%>
	<h3>'<%=keyword%>'에 대한 검색결과가 없습니다.</h3>
<%} %>
	
<jsp:include page="/template/footer.jsp"></jsp:include>