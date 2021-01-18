<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
<jsp:include page="/template/header.jsp"></jsp:include>

<div>
	<h1>여행꿀팁</h1>
</div>

<hr size="3" color="black">

<div class="container">
	<div class="item">
		<a href="<%=request.getContextPath()%>/tip_board/list.jsp?board_no=?">
			<img src="https://placeimg.com/200/200/any" width="200" height="200"></img>
			<br>
			<span>board_title</span>
			<br>
			<span>member_nick 여행작가</span>
		</a>
	</div>
</div>
	
<div class="center">
	<a href="">
		<span>여행꿀팁</span>
		<span>더보기&gt;</span>
	</a>
</div>


<div class="container">
	<div class="item">
		<a href="<%=request.getContextPath()%>/qna_board/list.jsp?board_no=?">
			<img src="https://placeimg.com/200/200/any" width="200" height="200"></img>
			<br>
			<span>board_title</span>
			<br>
			<span>member_nick 여행작가</span>
		</a>
	</div>
</div>
	
<div class="center">
	<a href="">
		<span>여행Q&amp;A</span>
		<span>더보기&gt;</span>
	</a>
</div>
	

<jsp:include page="/template/footer.jsp"></jsp:include>