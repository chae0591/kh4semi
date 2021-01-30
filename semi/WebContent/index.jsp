<%@page import="beans.QnaSearchVO"%>
<%@page import="beans.TipSearchVO"%>
<%@page import="beans.QnaBoardDto"%>
<%@page import="beans.QnaBoardDao"%>
<%@page import="java.util.List"%>
<%@page import="beans.TipBoardDto"%>
<%@page import="beans.TipBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");

	//여행꿀팁
	TipBoardDao tipboardDao = new TipBoardDao();
	List<TipSearchVO> tipList = tipboardDao.selectMain();
	
	//여행qna
	QnaBoardDao qnaboardDao = new QnaBoardDao();
	List<QnaSearchVO> qnaList = qnaboardDao.selectMain();
%>

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
    	margin-top: 15px;]
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
</style>


<jsp:include page="/template/header.jsp"></jsp:include>


<div class="contents left">
	<a href="<%=request.getContextPath()%>">전체</a>
	<span> &gt; </span> 
	<a href="<%=request.getContextPath()%>">추천콘텐츠</a>
</div>

<div class="bigTitle">여행꿀팁</div>

<div class="container-tip">
  	<%for(TipSearchVO tipsearchVO : tipList){ %>
	<div class="item border-gray-1">
  		<a href="<%=request.getContextPath()%>/tip_board/detail.jsp?board_no=<%=tipsearchVO.getBoard_no()%>">
			<span style="float:left; color:blue;">Tip</span>
			<span class="title-line"><%=tipsearchVO.getBoard_title() %></span>
			<span class="right-line"><%=tipsearchVO.getRegist_time() %></span>
			<br><br>
			<span class="content-line" style="margin-left: 2.5rem"><%=tipsearchVO.getBoard_content()%></span>
			<br>
			<span style="float:left; font-size:0.9em; margin-left: 2.5rem; ">일정 <%=tipsearchVO.getStart_date()%> ~ <%=tipsearchVO.getEnd_date() %></span>
			<span class="right-line" style="color:#8C8C8C"><%=tipsearchVO.getMember_nick() %> 여행작가</span>
		</a>
	</div>
	<%} %>
</div>

<div class="btn-box center">
	<a class="btn-more input" style="border-radius: 10px;" href="<%=request.getContextPath()%>/tip_board/list.jsp">여행꿀팁 더보기&gt;</a>
</div>

<div class="bigTitle">여행Q&amp;A</div>

<div class="container-qna">
  	<%for(QnaSearchVO qnasearchVO : qnaList){ %>
	<div class="item border-gray-1">
		<a href="<%=request.getContextPath()%>/qna_board/detail.jsp?board_no=<%=qnasearchVO.getBoard_no()%>">
			<span style="float:left; color:red;">Q&amp;A</span>
			<span class="title-line"><%=qnasearchVO.getBoard_title() %></span>
			<span class="right-line"><%=qnasearchVO.getRegist_time() %></span>
			<br><br>
			<span class="content-line" style="margin-left: 3.6rem"><%=qnasearchVO.getBoard_content() %></span>
			<br>
			<span style="margin-left: 3.6rem;"><%=qnasearchVO.getMember_nick()%></span><span style="color:#8C8C8C"> 님의 질문입니다</span>
		</a>
	</div>
	<%} %>
</div>

<div class="btn-box center" style="margin-bottom: 3rem">
	<a class="btn-more input" href="<%=request.getContextPath()%>/qna_board/list.jsp">여행Q&amp;A 더보기&gt;</a>
</div>

			
<jsp:include page="/template/footer.jsp"></jsp:include>		
		