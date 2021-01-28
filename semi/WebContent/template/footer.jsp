<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
</section>
		<footer>
			<span style="line-height:200%">
			상호명 : (주)디비go  |  사업자등록번호 : 123-45-67890  |  대표자 : 김채은
			<br>
			주소 : 서울특별시 강남구 코딩대로 123, 7층 (자바동, 스크립트빌딩)  |  통신판매업신고번호 : 제 2020-서울강남-0773 호
			<br>
			&copy; 2021 디비go, Inc. All Rights Reserved
			</span>
			<!-- 
				로그인 관련된 정보들을 출력(공부용)
				- 세션ID : 32글자의 16진수로 구성되어 있으며, 접속 시 랜덤으로 발급되며 같으면 같은 사용자로 인식한다.
				- check : 세션에 사용자의 번호를 저장하기 위한 값이며, 모든 페이지에서 유/무를 확인하여 로그인 처리 수행
			 
			 <h5 class="center">Session ID : <%=session.getId()%></h5>
			 <h5 class="center">check : <%=session.getAttribute("check")%></h5> 
			 -->
		</footer>
	</main>
</body>
</html>