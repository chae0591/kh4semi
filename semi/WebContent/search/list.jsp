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

	.container-tip{
		display: grid;
		grid-template-columns: repeat(2,1fr);
		grid-auto-rows: minmax(1em, auto);
		grid-gap: 1rem;
		justify-items: start;
		align-items: start;		
		padding: 10px 0 0 ;
		margin-left: 2.3rem;
	}
	
	.container-qna{
		display: grid;
		grid-template-columns: repeat(2,1fr);
		grid-auto-rows: minmax(1em, auto);
		grid-gap: 1rem;
		justify-items: start;
		align-items: start;	
		padding: 10px 0 0 ;	
		margin-left: 2.3rem;
	}	

	.item{
		padding: 1rem;
		width: 500px;
	}
	
	.border-gray-1 {
		border: 1px solid #999 !important;
  		border-radius: 10px;
	}
	
	.contents{
		min-height: 50px;
    	margin: 0 auto;
    	padding: 10px 0 0 ;
    	border-bottom: 1px solid #eeeeee;
    }
    
    .contents span{
    	float: left;
    	position: relative;
    	height: 40px;
    	line-height:40px;
    	color : #bbbbbb;
    	font-size: 14px;
    	font-weight: 500;
    }
    
    .contents a{
    	display: block;
    	float: left;
    	position: relative;
    	height: 40px;
    	line-height:40px;
    	color: #666666;
    	font-size: 14px;
    	font-weight: 500;
    }
    
    .bigTitle{
    	position: relative;
    	height: 60px;
    	line-height: 70px;
    	font-size: 23px;
    	font-weight: 700;
    	color: #454545;
    	border-bottom: 3px solid #454545;
    }
    
    .btn-box{
    	margin-top: 15px;
    	
    }
    
    .btn-more{
    	padding: 0.9rem !important;
    	height: 40px;
    	line-height: 40px;
    	border-radius: 10px;
    	font-size: 14px;
    	color: white;
    	background-color: #5edfdf;
    	border-style: none !important;
    }
    
    .right-line{
    	float:right; 
    	margin-right: 1rem;
    }
    
	/* 글 제목 글자수 제한 */
    .title-line{
    	float:left; 
    	font-size:1.1em; 
    	font-weight:500;
    	display: inline-block;
    	width:280px;
    	margin-left: 0.5em;
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    	color: #222;
    }
    
    .title-line:hover{
    	text-decoration: underline;
    }
    
    /* 글 내용 줄 제한 */
    .content-line{
    	font-size: 0.9em;
    	display: inline-block;
    	width:280px;
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    	white-space: normal;
    	line-height: 1.5;
    	height: 3em;
    	word-wrap: break-word;
    	display: -webkit-box;
    	-webkit-line-clamp: 2;
    	-webkit-box-orient: vertical;
    	color: #8c8c8c;
    }
    
    .content-line:hover{
    	text-decoration: underline;
    }
    
    .font {
	    font-family :'나눔고딕', 'Malgun Gothic', sans-serif;
	}
</style>


<jsp:include page="/template/header.jsp"></jsp:include>

<div class="contents left font">
	<a href="<%=request.getContextPath()%>">전체</a>
	<span> &gt; </span> 
	<a href="<%=request.getContextPath()%>">추천콘텐츠</a>
</div>

<div class="bigTitle font">여행꿀팁</div>

<%if(!tipList.isEmpty()){ %>
<div class="container-tip">

	<%for(TipSearchVO tipsearchVO : tipList){ %>
	<div class="item border-gray-1">
  		<a href="<%=request.getContextPath()%>/tip_board/detail.jsp?board_no=<%=tipsearchVO.getBoard_no()%>">
			<span class="font" style="float:left; color:blue;">Tip</span>
			<span class="font title-line"><%=tipsearchVO.getBoard_title() %></span>
			<span class="font right-line"><%=tipsearchVO.getRegist_time() %></span>
			<br><br>
			<span class="font content-line" style="margin-left: 2.5rem"><%=tipsearchVO.getBoard_content()%></span>
			<br>
			<span class="font" style="float:left; font-size:14px; margin-left: 2.5rem;">일정 <%=tipsearchVO.getStart_date()%> ~ <%=tipsearchVO.getEnd_date() %></span>
			<span class="font right-line" style="color:#8C8C8C"><%=tipsearchVO.getMember_nick()%> 여행작가</span>
		</a>
	</div>
	<%} %>
	
</div>

<div class="btn-box center">
	<a class="btn-more input" style="border-radius: 10px;" href="<%=request.getContextPath()%>/search/tiplist_more.jsp?keyword=<%=keyword%>">여행꿀팁 더보기&gt;</a>
</div>

<%} else{%>
	<h3 class="font">'<%=keyword%>'에 대한 검색결과가 없습니다.</h3>
	<br><br><br><br><br><br>
<%} %>

<div class="bigTitle font">여행Q&amp;A</div>

<%if(!qnaList.isEmpty()){%>
<div class="container-qna">

	<%for(QnaSearchVO qnasearchVO : qnaList){ %>
	<div class="item border-gray-1">
		<a href="<%=request.getContextPath()%>/qna_board/detail.jsp?board_no=<%=qnasearchVO.getBoard_no()%>">
			<span class="font" style="float:left; color:red;">Q&amp;A</span>
			<span class="title-line font"><%=qnasearchVO.getBoard_title()%></span>
			<span class="font right-line"><%=qnasearchVO.getRegist_time()%></span>
			<br><br>
			<span class="content-line font" style="margin-left: 3.6rem"><%=qnasearchVO.getBoard_content()%></span>
			<br>
			<span style="margin-left: 3.6rem;"><%=qnasearchVO.getMember_nick()%></span><span style="color:#8C8C8C"> 님의 질문입니다</span>
		</a>
	</div>
	<%} %>
	
</div>

<div class="btn-box center" style="margin-bottom: 3rem">
	<a class="btn-more input" href="<%=request.getContextPath()%>/search/qnalist_more.jsp?keyword=<%=keyword%>">여행Q&amp;A 더보기&gt;</a>
</div>

<%} else{%>
	<h3 class="font">'<%=keyword%>'에 대한 검색결과가 없습니다.</h3>
	<br><br><br><br><br><br><br><br><br>
<%} %>
	
<jsp:include page="/template/footer.jsp"></jsp:include>