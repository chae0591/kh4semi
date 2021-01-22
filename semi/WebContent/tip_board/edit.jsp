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

function copyContent () {
	console.log('copyCon');
    document.getElementById("board_content").value =  
        document.getElementById("textEditor").innerHTML;
    console.log(document.getElementById("board_content").value);
    return true;
}

$(document).ready(function() {
	
    // process the form
    $('#imgUploadForm').submit(function(evt) {
    	console.log('start');
        evt.preventDefault();
        var formData = new FormData($(this)[0]);
	     $.ajax({
	        url: '<%=request.getContextPath()%>/file/receive.do',
	        data: formData,
	        dataType : "json",
            type: "POST",
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            timeout: 10000,
            success: function (data) {
                console.log("data : ", data);
                //var img = $('<img>'); 
				//img.attr('src', data.imgUrl);
				//img.appendTo('#texteditor');

			    var editer = document.getElementById('textEditor');
			    var filePath = data.imgUrl;
			    editer.focus();
			    document.execCommand('InsertImage', false, filePath);
            },
            error: function (e) {
                console.log("ERROR : ", e);
            }
	     });
	     return false;
    });

});
</script>
<style>
#textEditor div {
	border:none !important;
}
</style>

<div class="outbox" style="width:800px">
	<div class="row center">
		<h2>게시글 수정</h2>
	</div>
	<div class="row center">상대방에 대한 인신공격은 예고 없이 삭제될 수 있습니다</div>
	
	<form onsubmit='return copyContent();' action="<%=request.getContextPath()%>/tip_board/edit.do" method="post">
	
	<!-- 사용자 몰래 번호를 첨부 -->
	<input type="hidden" name="board_no" value="<%=boardDto.getBoard_no()%>">
	
	<div class="row">
		<label>시작일</label>
		<input type="date" name="start_date"
		value="<%=boardDto.getStart_date() %>"
       min="1900-01-01" max="2100-12-31" required>
		<label>종료일</label>
		<input type="date" name="end_date"
		value="<%=boardDto.getEnd_date() %>"
       min="1900-01-01" max="2100-12-31" required>
	</div>
	
	
	<div class="row">
		<label>제목</label>
		<input type="text" class="input" name="board_title" value="<%=boardDto.getBoard_title()%>" required>
	</div>
	
	<div class="row">
		<label>내용</label>
		<textarea style="display:none;" id="board_content" name="board_content" class="input"></textarea>
		<div id="textEditor" class="input" contenteditable="true">
			<%=boardDto.getBoard_content()%>
		</div>
	</div>
	
	<div class="row">
		<input type="submit" class="input" value="수정">
	</div>
	 
	</form>
	<div class="row">
		<label>이미지 업로드</label>
		<form id="imgUploadForm" action="<%=request.getContextPath()%>/file/receive.do" method="post" enctype="multipart/form-data">
			<input id="file" type="file" name="f" accept=".jpg , .png , .gif">
			<br><br>
			<input type="submit" value="업로드">
		</form>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>







