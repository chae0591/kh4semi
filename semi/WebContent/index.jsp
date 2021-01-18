<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.container-tip{
		display: grid;
		grid-template-rows: repeat(2,300px);
		grid-template-columns: repeat(3,1fr);
		padding: 10px 0 0 ;
	}
	
	.container-qna{
		display: grid;
		grid-template-rows: repeat(2,200px);
		grid-template-columns: repeat(2,1fr);
		padding: 10px 0 0 ;
	}	
	
	.item{
		padding: 10px 0 0;
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
	<span> > </span> 
	<a href="<%=request.getContextPath()%>">추천콘텐츠</a>
</div>

<div class="bigTitle">여행꿀팁</div>

<div class="container-tip">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
  <div class="item">6</div>
</div>

<div class="btn-box center">
	<a class="btn-more input" href="<%=request.getContextPath()%>/tip_board/list.jsp">여행꿀팁 더보기</a>
</div>

<div class="bigTitle">여행Q&A</div>

<div class="container-qna">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
</div>

<div class="btn-box center">
	<a class="btn-more input" href="<%=request.getContextPath()%>/qna_board/list.jsp">여행Q&A 더보기</a>
</div>

			
<jsp:include page="/template/footer.jsp"></jsp:include>		
		