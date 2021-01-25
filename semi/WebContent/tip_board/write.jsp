<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/template/header.jsp"></jsp:include>
<script>
var state = {
	file_no_list: []
};

function copyContent () {
    document.getElementsByName("file_no_list")[0].value = state.file_no_list
    document.getElementsByName("board_content")[0].value =  
        document.getElementById("textEditor").innerHTML;
    return true;
}

$(document).ready(function() {
	
    // process the form
    $('#imgUploadForm').submit(function(evt) {
        evt.preventDefault();
        var formData = new FormData($(this)[0]);
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
            	console.log(data);
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
		<h2>게시글 작성</h2>
	</div>
	<div class="row center">상대방에 대한 인신공격은 예고 없이 삭제될 수 있습니다</div>
	
	<form onsubmit='return copyContent();' action="write.do" method="post" >
		
		<!-- 사용자 몰래 번호를 첨부 -->
		<input type="hidden" name="file_no_list">
		
		<div class="row">
			<label>시작일</label>
			<input type="date" name="start_date"
	       min="1900-01-01" max="2100-12-31" required>
			<label>종료일</label>
			<input type="date" name="end_date"
	       min="1900-01-01" max="2100-12-31" required>
		</div>
		
		<div class="row">
			<label>제목</label>
			<input type="text" class="input" name="board_title" required>
		</div>
		
		<div class="row">
			<label>내용</label>
			<textarea style="display:none;" name="board_content" class="input"></textarea>
			<div id="textEditor" class="input" contenteditable="true">
				<br><br><br><br><br><br><br><br><br><br><br>
			</div>
		</div>
		
		<div class="row">
			<input type="submit" class="input" value="등록">
		</div>
		 
	</form>
	<div class="row">
		<label>이미지 업로드</label>
		<form id="imgUploadForm" action="<%=request.getContextPath()%>/tip_tmp_file/receive.do" method="post" enctype="multipart/form-data">
			<input id="file" type="file" name="f" accept=".jpg , .png , .gif">
			<br><br>
			<input type="submit" value="업로드">
		</form>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>



