<%@page import="java.util.List"%>
<%@page import="beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String keyword = request.getParameter("keyword");
	
	//여행꿀팁
	QnaBoardDao qnaboardDao = new QnaBoardDao();
	

	//페이지 분할 코드
	int boardSize = 10;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e){
		p = 1;
	}
	
	int endRow = p * boardSize;
	int startRow = endRow - boardSize + 1;
	
	
	//페이지 블록 개수 코드
	int blockSize = 10;
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	int count = qnaboardDao.searchCount(keyword);
	
	// 페이지 개수
	int	pageSize = (count + boardSize - 1) / boardSize;
	if(endBlock > pageSize){
		endBlock = pageSize;
	}

	List<QnaSearchVO> qnaList = qnaboardDao.searchPagingList(keyword, startRow, endRow);
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
		margin-left: 1.2rem;
	}
	
	.container-qna{
		display: grid;
		grid-template-columns: repeat(2,1fr);
		grid-auto-rows: minmax(1em, auto);
		grid-gap: 1rem;
		justify-items: start;
		align-items: start;	
		padding: 10px 0 0 ;	
		margin-left: 1.2rem !important;
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
    	padding: 0 35px;
    	height: 35px;
    	line-height: 35px;
    	border: 1px solid #ddd;
    	border-radius: 2px;
    	font-size: 14px;
    	color: #333;
    	border-radius: 10px;
    }
    
    .right-line{
    	float:right; 
    	margin-right: 1rem;
    }
    
	/* 글 제목 글자수 제한 */
    .title-line{
    	float:left; 
    	font-size:1.1em; 
    	font-weight:600;
    	display: inline-block;
    	width:280px;
    	margin-left: 0.5em;
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
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
    }
    
    .content-line:hover{
    	text-decoration: underline;
    }
    
</style>


<jsp:include page="/template/header.jsp"></jsp:include>

<div class="bigTitle">여행Q&amp;A</div>

<div class="container-qna outbox">

	<%for(QnaSearchVO qnasearchVO : qnaList){ %>
	<div class="item border-gray-1">
  		<a href="<%=request.getContextPath()%>/qna_board/detail.jsp?board_no=<%=qnasearchVO.getBoard_no()%>">
			<span style="float:left; color:red;">Q&amp;A</span>
			<span class="title-line"><%=qnasearchVO.getBoard_title()%></span>
			<span class="right-line"><%=qnasearchVO.getRegist_time()%></span>
			<br><br>
			<span class="content-line" style="margin-left: 2.9rem"><%=qnasearchVO.getBoard_content()%></span>
			<br>
			<span style="color:#8C8C8C; margin-left: 2.9rem"><%=qnasearchVO.getMember_nick()%> 님의 질문입니다</span>
		</a>
	</div>
	<%} %>
</div>

<div class="btn-box center">
	 <ul class="pagination">
	    <li><a href="<%=request.getContextPath()%>/search/qnalist_more.jsp?keyword=<%=keyword%>&p=<%=startBlock-1%>">&lt;</a></li>
	    
	 <%for(int i=startBlock ; i <=  endBlock ; i++){ %>
	 	<%if(p == i){ %>
       		<li class="active"><a href="<%=request.getContextPath()%>/search/qnalist_more.jsp?keyword=<%=keyword%>&p=<%=i%>"><%=i%></a></li>
        <%} else{%>
        	<li><a href="<%=request.getContextPath()%>/search/qnalist_more.jsp?keyword=<%=keyword%>&p=<%=i%>"><%=i%></a></li>
        <%} %>	
      <%} %>
      
      <%if(endBlock != pageSize){ %>
      	<li><a href="<%=request.getContextPath()%>/search/qnalist_more.jsp?keyword=<%=keyword%>&p=<%=endBlock+1%>">&gt;</a></li>
      <%}%>	 
    </ul>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>