<%@page import="beans.TipBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.TipBoardDao"%>
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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" crossorigin="anonymous">
<style>
	/* 화면 레이아웃 스타일 */
	
	/* 모든 영역은 점선으로 테두리가 표시되게 한다(테스트용 삭제)
	main, header, nav, section, 
	aside, article, footer, div,
	label, span, p {
	}
	*/
	
	/* 모든 영역 폰트 설정*/
	main, header, nav, section, 
	aside, article, footer, div,
	label, span, p {
		font-family :'나눔고딕', 'Malgun Gothic', sans-serif;
	}
	
	/* 헤더와 섹션의 폭은 1100px 로 한다 */
	header, section {
		width:1100px;
		margin:auto;
	}
	
	nav, footer, .slide {
		width:100%;
	}
	
	.top{
		width:1100px;
		margin:auto;
		margin-top: 1.2rem;
	}
	
	/* 각각의 레이아웃 영역에 여백을 설정한다 */
	header, footer, section {
		padding:1rem;
	}
	
	/* 본문에 내용이 없어도 최소높이를 설정하여 일정 크기만큼 표시되도록 한다 */
	section {
		min-height: 500px;
	}
	
	footer {
		min-height: 300px;
		padding-top: 8rem;
		background-color: #DFF9F9;
		font-size: 12px;
		font-weight:700;
		color: #5D5D5D;
		margin: auto;
	}
	
	.logo {
	    float: left;
	    width: 200px;
	    height: 90px;
    }
    
    .log-btn {
        display: inline-block;
        padding: 1rem;
    }
	
	.menu,
    .menu ul {
        list-style: none;
        padding: 1.4rem;
        height:68px;
        margin-top: 10px;
        background-color: #5edfdf;
        font-weight: 600;
        font-size: 18px;
    }
    
    .menu>li,
    .menu>li>a {
        width: 250px;
        display: inline-block;
        position: relative;
        color: #fff;
    }
    
    .menu>li>a:hover{
    	color: #119e9e;
    	font-weight: 900;
    	font-size:19px;
    	text-decoration: underline;
    }
        
    a{
	    text-decoration: none;
	    color: black;
    }
    
    /* banner */
    * {
	  margin: 0px;
	  padding: 0px;
	}
    
	ul,
	ol,
	li {
	  list-style: none;
	}
	
	img {
	  vertical-align: top;
	  border: none;
	}
	
	.slide {
	  position: relative;
	  padding-top: 30px;
	  overflow: hidden;
	}
	
	.panel {
	  width: 400%;
	}
	
	.panel:after {
	  content: "";
	  display: block;
	  clear: both;
	}
	
	.panel>li {
	  width: 25%;
	  height: 370px;
	  float: left;
	  background-repeat: no-repeat;
	  background-size: 100% 100%;
	  position: relative;
	}
	
	.dot:after {
	  content: "";
	  display: block;
	  clear: both;
	}
	
	.dot {
	  position: absolute;
	  left: 50%;
	  bottom: 10%;
	  transform: translateX(-50%);
	}
	
	.dot>li {
	  float: left;
	  width: 25px;
	  height: 25px;
	  border-radius: 50%;
	  background-color: #fff;
	  margin-left: 10px;
	  margin-right: 10px;
	  text-indent: -9999px;
	  cursor: pointer;
	}
	
	.dot>li.on {
	  background-color: #3DB7CC;
	}
	
	.slide .btnmove{
      position: absolute;
      top: 55%;
  	  transform: translateY(-50%);
  	  cursor: pointer;
      width: 40px;
      height: 85px;
      z-index: 1;
      font-size: 4em;
      opacity: 0.5;
	}
	
	.slide .btnmove.prev{
	  left: 10px;
	}
	.slide .btnmove.next{
	  right: 10px;
	}
	.slide i{
	  color: #fff;
	}
        
    /* dropdown style */
    .dropdown {
	  position: relative;
	  display: inline-block;
	  color: black; 
	  font-family :'나눔고딕', 'Malgun Gothic', sans-serif;
	}
	
	.dropdown-content {
	  display: none;
	  position: absolute;
	  background-color: #f3f6f7;
	  min-width: 160px;
	  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	  padding: 12px 16px;
	  z-index: 1;
	  float: right;
	  text-align: center;
	}
	.dropdown:hover .dropbtn {
		font-weight: bold;
		color: black;
	}
	.dropdown-content p:hover {
		width: auto;
		font-weight: bold;
	}
	
	
	.dropdown:hover .dropdown-content {
	  display: block;
	}
   
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script language="JavaScript">

$(document).ready(function() {
	  slide();
});
	
//슬라이드 
function slide() {
  var wid = 0;
  var now_num = 0;
  var slide_length = 0;
  var auto = null;
  var $dotli = $('.dot>li');
  var $panel = $('.panel');
  var $panelLi = $panel.children('li');

  // 변수 초기화
  function init() {
    wid = $('.slide').width();
    now_num = $('.dot>li.on').index();
    slide_length = $dotli.length;
  }

  // 이벤트 묶음
  function slideEvent() {

    // 슬라이드 하단 dot버튼 클릭했을때
    $dotli.click(function() {
      now_num = $(this).index();
      slideMove();
    });

    // 이후 버튼 클릭했을때
    $('.next').click(function() {
      nextChkPlay();
    });

    // 이전 버튼 클릭했을때
    $('.prev').click(function() {
      prevChkPlay();
    });

    // 오토플레이
    autoPlay();

    // 오토플레이 멈춤
    autoPlayStop();

    // 오토플레이 재시작
    autoPlayRestart();

    // 화면크기 재설정 되었을때
    resize();
  }

  // 자동실행 함수
  function autoPlay() {
    auto = setInterval(function() {
      nextChkPlay();
    }, 5000);
  }

  // 자동실행 멈춤
  function autoPlayStop() {
    $panelLi.mouseenter(function() {
      clearInterval(auto);
    });
  }

  // 자동실행 멈췄다가 재실행
  function autoPlayRestart() {
    $panelLi.mouseleave(function() {
      auto = setInterval(function() {
        nextChkPlay();
      }, 5000);
    });
  }

  // 이전 버튼 클릭시 조건 검사후 슬라이드 무브
  function prevChkPlay() {
    if (now_num == 0) {
      now_num = slide_length - 1;
    } else {
      now_num--;
    }
    slideMove();
  }

  // 이후 버튼 클릭시 조건 검사후 슬라이드 무브
  function nextChkPlay() {
    if (now_num == slide_length - 1) {
      now_num = 0;
    } else {
      now_num++;
    }
    slideMove();
  }

  // 슬라이드 무브
  function slideMove() {
    $panel.stop().animate({
      'margin-left': -wid * now_num
    });
    $dotli.removeClass('on');
    $dotli.eq(now_num).addClass('on');
  }

  // 화면크기 조정시 화면 재설정
  function resize() {
    $(window).resize(function() {
      init();
      $panel.css({
        'margin-left': -wid * now_num
      });
    });
  }
  init();
  slideEvent();
}
</script>
<script>

</script>
</head>
<body>
	<main>
		<header>
			<div class="right top">
				<a href="<%=request.getContextPath()%>">
	            	<img class="logo" alt="디비go" src="http://localhost:8888/semi/images/logo.png">
	            </a>
	            
	            <!-- 비회원이 마주할 메뉴 -->
	            <%if(!isLogin){ %>
	            <a href="<%=request.getContextPath()%>/member/login.jsp" class="log-btn">로그인</a>

	            <!-- 회원이 마주할 메뉴 -->
	            <%}else{ %>
	            <div class="dropdown">
	            	<span class="log-btn dropbtn">  <%=session.getAttribute("nick") %>님 환영합니다 </span>	
	            	<div class="dropdown-content">
	            		<p><a href="<%=request.getContextPath()%>/member/my.jsp" class="log-my">내정보</a></p>
	            		<p><a href="<%=request.getContextPath()%>/member/logout.do" class="log-btn">로그아웃</a></p>
	            	</div>
	            </div>
	            
	            <%} %>
	            
	            <form action="<%=request.getContextPath()%>/search/list.jsp" method="post" style="margin-block-end: 1rem">
		            <input type="text" name="keyword" placeholder="검색어 입력" class="input input-inline">
		            <input type="submit" value="검색" class="input input-inline">
	            </form>
            </div>
		</header>
		<nav>
			<ul class="menu center">
				<li><a href="<%=request.getContextPath()%>">추천 콘텐츠</a></li>
				<li><a href="<%=request.getContextPath()%>/tip_board/list.jsp">여행꿀팁</a></li>
				<li><a href="<%=request.getContextPath()%>/qna_board/list.jsp">여행Q&amp;A</a></li>
			</ul>
		</nav>
		
		<div class="slide">
  			<ul class="panel">
				<li>
					<a href="<%=request.getContextPath()%>">
						<img src="https://media.istockphoto.com/vectors/cartoon-banner-of-the-flying-plane-and-cloud-on-blue-sky-background-vector-id911262920?k=6&m=911262920&s=170667a&w=0&h=FBPrLChHXnlZEy_k0_-lXtICgL0h4T_yrglyJt1sEmQ=" width="100%" height="370px">
					</a>
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/tip_board/list.jsp">
						<img src="https://image.freepik.com/free-vector/various-travel-attractions-in-paper-art-style_67590-514.jpg" width="100%" height="370px">
					</a>
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/qna_board/list.jsp">
						<img src="https://img.freepik.com/free-vector/summer-holidays-retro-van-and-surf-boards-travel-and-people-concept-smiling-young-hippie-friends-in-minivan-car-on-beach_108939-334.jpg?size=626&ext=jpg&uid=R33195769&ga=GA1.2.300558524.1610501897" width="100%" height="370px">
					</a>
				</li>
			</ul>
			<div class="prev btnmove">
       			<i class="fas fa-chevron-left"></i>
   			</div>
   			<div class="next btnmove">
       			<i class="fas fa-chevron-right"></i>
  			</div>
  			<ul class="dot">
			    <li class="on">슬라이드 버튼1번</li>
			    <li>슬라이드 버튼2번</li>
			    <li>슬라이드 버튼3번</li>
			 </ul>
		</div>
	
		<section>