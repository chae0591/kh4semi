<%@page import="java.util.List"%>
<%@page import="beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String keyword = request.getParameter("keyword");
	
	//여행꿀팁
	TipBoardDao tipboardDao = new TipBoardDao();
	

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

	//List<TipSearchVO> tipList1 = tipboardDao.searchPagingList(keyword, startRow, endRow);
	List<TipSearchVO> tipList = tipboardDao.select1(keyword);
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

<div class="contents left">
	<a href="<%=request.getContextPath()%>">전체</a>
	<span> &gt; </span> 
	<a href="<%=request.getContextPath()%>">추천콘텐츠</a>
</div>

<div class="bigTitle">여행꿀팁</div>

<div class="container-tip outbox">

	<%for(TipSearchVO tipsearchVO : tipList){ %>
	<div class="item">
  		<a href="<%=request.getContextPath()%>/tip_board/detail.jsp?board_no=<%=tipsearchVO.getBoard_no()%>">
			<span style="float:left; color:blue;">Tip&nbsp;</span>
			<span style="float:left; font-size:1.1em; font-weight:600; width:250px;"><%=tipsearchVO.getBoard_title() %></span>
			<span style="float:right"><%=tipsearchVO.getRegist_time() %></span>
			<br><br>
			<span style="float:left"><%=tipsearchVO.getBoard_content() %></span>
			<br><br>
			<span style="float:left; font-size:14px;">일정 <%=tipsearchVO.getStart_date()%> ~ <%=tipsearchVO.getEnd_date() %></span>
			<span style="float:right; color:#8C8C8C;"><%=tipsearchVO.getMember_nick()%> 여행작가</span>
		</a>
	</div>
	<%} %>
</div>
	
	 <ul class="pagination center">
	    <li><a href="<%=request.getContextPath()%>/search/tiplist_more?keyword=<%=keyword%>&p=<%=startBlock-1%>">&lt;</a></li>
	    
	 <%for(int i=startBlock ; i <  endBlock ; i++){ %>
        <li><a href="<%=request.getContextPath()%>/search/tiplist_more?keyword=<%=keyword%>&p=<%=i%>"><%=i%></a></li>
      <%} %>
      
      	<li><a href="<%=request.getContextPath()%>/search/tiplist_more?keyword=<%=keyword%>&p=<%=endBlock+1%>">&gt;</a></li> 
    </ul>

<jsp:include page="/template/footer.jsp"></jsp:include>
