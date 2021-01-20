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
		grid-template-columns: repeat(4, 1fr);
		grid-auto-rows: minmax(10em, auto);
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
		<a href="<%=request.getContextPath()%>/tip_board/list.jsp?board_no=<%=tipsearchVO.getBoard_no()%>">
			<img src="https://placeimg.com/200/200/any" width="200" height="200"></img>
			<br>
			<span><%=tipsearchVO.getBoard_title()%></span>
			<br>
			<span><%=tipsearchVO.getMember_nick() %> 여행작가</span>
		</a>
	</div>
	<%} %>
</div>

<div class="center">
	<a href="" class="btn-more input">
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
	
	<div class="center">
		<a href="" class="btn-more input">
			<span>여행Q&amp;A</span>
			<span>더보기&gt;</span>
		</a>
	</div>
	<%} %>
</div>
<%} else{%>
	<h3>'<%=keyword%>'에 대한 검색결과가 없습니다.</h3>
<%} %>
	

	

<jsp:include page="/template/footer.jsp"></jsp:include>