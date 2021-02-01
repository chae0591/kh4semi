<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.*" %>

<%
// 	상세보기처럼 번호를 이용해서 글을 불러온다(조회수 증가는 하지 않음)
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	TipBoardDao boardDao = new TipBoardDao();
	TipBoardDto boardDto = boardDao.find(board_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<script>

var state = {
	file_no_list: []
};

function copyContent () {
    document.getElementsByName("file_no_list")[0].value = state.file_no_list.join()
    document.getElementsByName("board_content")[0].value =  
        document.getElementById("textEditor").innerHTML;
    return true;
}

$(document).ready(function() {

    $('#btn-upload').click(function(e){
        e.preventDefault();
        $('#file').click();
    });
    
	document.getElementById("file").onchange = function(evt) {
        var formData = new FormData($('#imgUploadForm')[0]);
	     $.ajax({
	        url: '<%=request.getContextPath()%>/tip_tmp_file/receive.do',
	        data: formData,
	        dataType : "json",
           type: "POST",
           enctype: 'multipart/form-data',
           processData: false,
           contentType: false,
           cache: false,
           timeout: 10000,
           success: function (data) {
                state.file_no_list.push(data.file_no);
			    var editer = document.getElementById('textEditor');
			    var filePath = data.imgUrl;
			    editer.focus();
			    document.execCommand('InsertImage', false, filePath);
           },
           error: function (e) {
           	alert("이미지 업로드에 실패하였습니다.");
               console.log("ERROR : ", e);
           }
	     });
	};
	
	//취소하고 이전 페이지로 넘어가기
	$(".btn-cancel").click(function(){
			history.go(-1);
	});
});
</script>
<style>

.img-container img{
	max-width:100%;
}

label, div, span, a {
	border: none !important;
}


#textEditor {
	border: 1px solid #ccc !important;
	border-radius: 5px;
	min-height: 500px;
}

</style>

<div class="outbox" style="width:800px">
	<div class="row center">
		<h2>여행꿀팁 수정</h2>
	</div>
	
	<form onsubmit='return copyContent();' action="<%=request.getContextPath()%>/tip_board/edit.do" method="post">
	
	<!-- 사용자 몰래 번호를 첨부 -->
	<input type="hidden" name="board_no" value="<%=boardDto.getBoard_no()%>">
			
	<!-- 사용자 몰래 번호를 첨부 -->
	<input type="hidden" name="file_no_list">
		
	<div class="row form-inline">
		<label>시작일</label>
		<input type="date" class="form-control" name="start_date"
		value="<%=boardDto.getStart_date() %>"
       min="1900-01-01" max="2100-12-31" required>
		<label>종료일</label>
		<input type="date" class="form-control" name="end_date"
		value="<%=boardDto.getEnd_date() %>"
       min="1900-01-01" max="2100-12-31" required>
	</div>
	
	<br>
	<div class="row">
		<label>제목</label>
		<input type="text" class="input form-control" name="board_title" value="<%=boardDto.getBoard_title()%>" required>
	</div>
	
	<br>
	<div class="row">
		<label>내용</label>
		<div>
			<button id='btn-upload' class="btn btn-default">이미지 업로드</button>
		</div>
		<br>
		<textarea style="display:none;" id="board_content" name="board_content" class="input"></textarea>
		<div id="textEditor" class="input img-container" contenteditable="true">
			<%=boardDto.getBoard_content()%>
		</div>
	</div>
	<br>
	
	<div class="row">
		<input type="submit" class="input btn btn-info" value="수정">
		<input type="button" class="input btn btn-cancel" value="취소">
	</div>
	 
	</form>
	
	<div style="display:none;">
		<label>이미지 업로드</label>
		<form id="imgUploadForm" action="<%=request.getContextPath()%>/tip_tmp_file/receive.do" method="post" enctype="multipart/form-data">
			<input id="file" type="file" name="f" accept=".jpg , .png , .gif">
			<!-- 
			<br><br>
			<input type="submit" value="업로드">			
			-->
		</form>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>







