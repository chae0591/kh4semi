<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="beans.*" %>

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

window.onload = function() {

    $('#btn-upload').click(function(e){
        e.preventDefault();
        $('#file').click();
    });
    
	document.getElementById("file").onchange = function(evt) {
	    //document.getElementById("imgUploadForm").submit();
        var formData = new FormData($('#imgUploadForm')[0]);
	     $.ajax({
	        url: '<%=request.getContextPath()%>/qna_tmp_file/receive.do',
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
           		//alert("이미지가 업로드 되었습니다.");
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

};
</script>
<div class="outbox" style="width:800px">
	<div class="row center">
		<h2>게시글 작성</h2>
	</div>
	
	<form onsubmit='return copyContent();' action="write.do" method="post">
	
		<!-- 사용자 몰래 번호를 첨부 -->
		<input type="hidden" name="file_no_list">
		
	<div class="row">
		<label>제목</label>
		<input type="text" class="input" name="board_title" required>
	</div>
	<div class="row">
		<label>내용</label>
		<div>
			<button id='btn-upload'>이미지 업로드</button>
		</div>
		<textarea style="display:none;" name="board_content" class="input"></textarea>
		<div id="textEditor" class="input" contenteditable="true">
			
		</div>
	</div>
	
	<div class="row">
		<input type="submit" class="input" value="등록">
	</div>
	 
	</form>
	
	<div style="display:none;">
		<label>이미지 업로드</label>
		<form id="imgUploadForm" action="<%=request.getContextPath()%>/qna_tmp_file/receive.do" method="post" enctype="multipart/form-data">
			<input id="file" type="file" name="f" accept=".jpg , .png , .gif">
			<!-- 
			<br><br>
			<input type="submit" value="업로드">			
			-->
		</form>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>