<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
	//로그인 상태 : session 에 check 라는 이름의 값이 존재할 경우(null이 아닌 경우)
	//로그아웃 상태 : session 에 check 라는 이름의 값이 존재하지 않을 경우(null인 경우)
	boolean isLogin = session.getAttribute("check") != null;
	
	//사용자가 관리자인지 계산하는 코드 ..?
	//String auth = (String)session.getAttribute("auth");
	//boolean isAdmin = isLogin && auth.equals("관리자");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>디비go</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<style>
	/* 화면 레이아웃 스타일 */
	
	/* 모든 영역은 점선으로 테두리가 표시되게 한다(테스트용) */
	main, header, nav, section, 
	aside, article, footer, div,
	label, span, p {
		border: 1px dotted #ccc;
	}
	
	/* 전체 화면의 폭은 1100px 로 한다 */
	main {
		width:1100px;
		margin:auto;
	}
	
	/* 각각의 레이아웃 영역에 여백을 설정한다 */
	header, footer, nav, section {
		padding:1rem;
	}
	
	/* 본문에 내용이 없어도 최소높이를 설정하여 일정 크기만큼 표시되도록 한다 */
	section {
		min-height: 500px;
		margin-left: 5rem;
        margin-right: 5rem;
	}
	/* 로고있는 상단 부분 좌우 마진 */
	.top{
        margin-left: 5rem;
        margin-right: 5rem;
    }
	
	.logo {
	    float: left;
    }
    
    .log-btn {
        display: inline-block;
        padding: 1rem;
    }
    
    .join-btn {
    	display: inline-block;
        padding: 1rem;
        margin-right: 1rem;
    }
	
	.menu,
    .menu ul {
        list-style: none;
        margin: 0;
        padding: 0rem;
    }

    .menu>li {
        width: 200px;
        display: inline-block;
        position: relative;
    }
        
    a{
	    text-decoration: none;
	    color: black;
    }
    
    /* banner */
	.banner {position: relative; width: 1100px; height: 320px; top: 20px;  margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 1100px; height: 320px; margin:0; padding:0;}
        
   
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script language="JavaScript">
<!--
	$(document).ready(function() {
		var $banner = $(".banner").find("ul");

		var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
		var $bannerHeight = $banner.children().outerHeight(); // 높이
		var $length = $banner.children().length;//이미지의 갯수
		var rollingId;

		//정해진 초마다 함수 실행
		rollingId = setInterval(function() { rollingStart(); }, 6000);//다음 이미지로 롤링 애니메이션 할 시간차
    
		function rollingStart() {
			$banner.css("width", $bannerWidth * $length + "px");
			$banner.css("height", $bannerHeight + "px");
			//alert(bannerHeight);
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 3000, function() { //숫자는 롤링 진행되는 시간이다.
				//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
	}); 
//-->  
</script>
<script>

</script>
</head>
<body>
	<main>
		<header>
			<div class="right top">
				<a href="<%=request.getContextPath()%>">
	            	<img class="logo" alt="디비go" src="https://placehold.it/200x90?text=dibigo">
	            </a>
	            
	            <!-- 비회원이 마주할 메뉴 -->
	            <%if(!isLogin){ %>
	            <a href="<%=request.getContextPath()%>/user/login.jsp" class="log-btn">로그인</a>
	            <a href="<%=request.getContextPath()%>/user/join.jsp" class="join-btn">회원가입</a>
	            
	            <!-- 회원이 마주할 메뉴 -->
	            <%}else{ %>
	            <a href="<%=request.getContextPath()%>/user/logout.do" class="log-btn">로그아웃</a>
	            <%} %>
	            
	            <form action="<%=request.getContextPath()%>/search/list.jsp" method="post">
		            <input type="text" name="keyword" placeholder="검색어 입력" class="input input-inline">
		            <input type="submit" value="검색" class="input input-inline">
	            </form>
            </div>
		</header>
		<nav>
			<ul class="menu center">
				<li><a href="<%=request.getContextPath()%>">추천 콘텐츠</a></li>
				<li><a href="<%=request.getContextPath()%>/tip_board/list.jsp">여행꿀팁</a></li>
				<li><a href="<%=request.getContextPath()%>/qna_board/list.jsp">여행Q&A</a></li>
			</ul>
		</nav>
		<div class="contents">
		<div class="banner">
			<ul>
			
				<li>
					<a href="<%=request.getContextPath()%>/tip_board/list.jsp">
						<img src="https://image.shutterstock.com/z/stock-photo-top-view-beach-umbrella-with-chairs-and-beach-accessories-on-blue-background-summer-vacation-1289229208.jpg" width="1100" height="320px">
					</a>
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/qna_board/list.jsp">
						<img src="https://image.shutterstock.com/z/stock-photo-top-view-beach-umbrella-with-chairs-and-beach-accessories-on-pastel-pink-background-summer-1308737056.jpg" width="1100" height="320px">
					</a>
				</li>
			</ul>
		</div>
	</div>
		<section>