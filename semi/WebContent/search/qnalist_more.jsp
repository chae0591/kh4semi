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
<h2>startBlock=<%=startBlock%>, endBlock=<%=endBlock%>, pageSize=<%=pageSize%></h2>
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
	}
	
	.container-qna{
		display: grid;
		grid-template-columns: repeat(2,1fr);
		grid-auto-rows: minmax(1em, auto);
		grid-gap: 0.5rem;
		justify-items: start;
		align-items: start;	
		padding: 10px 0 0 ;	
	}	

	.item{
		padding: 1rem;
		width: 440px;
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
    	font-size: 25px;
    	font-weight: 700;
    	border-bottom: 3px solid #242424;
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
    }
</style>


<jsp:include page="/template/header.jsp"></jsp:include>

<div class="bigTitle">여행Q&amp;A</div>

<div class="container-qna outbox">

	<%for(QnaSearchVO qnasearchVO : qnaList){ %>
	<div class="item">
  		<a href="<%=request.getContextPath()%>/qna_board/detail.jsp?board_no=<%=qnasearchVO.getBoard_no()%>">
			<span style="float:left; color:red;">Q&amp;A&nbsp;</span>
			<span style="float:left; font-size:1.1em; font-weight:600; width:250px;"><%=qnasearchVO.getBoard_title()%></span>
			<span style="float:right"><%=qnasearchVO.getRegist_time()%></span>
			<br><br>
			<span style="float:left"><%=qnasearchVO.getBoard_title()%></span>
			<br><br>
			<span style="color:#8C8C8C"><%=qnasearchVO.getMember_nick()%> 님의 질문입니다</span>
		</a>
	</div>
	<%} %>
</div>
	
	 <ul class="pagination center">
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

<jsp:include page="/template/footer.jsp"></jsp:include>