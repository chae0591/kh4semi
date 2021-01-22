<%@page import="java.util.List"%>
<%@page import="beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String keyword = request.getParameter("keyword");
	
	//여행꿀팁
	TipBoardDao tipboardDao = new TipBoardDao();
	List<TipSearchVO> tipList = tipboardDao.select1(keyword);
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

<jsp:include page="/template/footer.jsp"></jsp:include>
