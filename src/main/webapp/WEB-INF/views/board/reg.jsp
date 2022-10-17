<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>

$(function(){
	var tmp =0;
	$("#fileAdd").click(function(){
		var html = "<div><input type=file name=file"+tmp+" id=file"+tmp+" onchange=fncNameChk(this)>";
			html += "<input type=button name=fileDel"+tmp+" id=fileDel"+tmp+" value=삭제 onclick=fncFileDel(this)></div>";
		$("#fileDv").append(html);
		tmp += 1;
	})

});


function fncFileDel(btnDel){
	$(btnDel).parent().remove();
}

function fncNameChk(fileInput){
	var ext = $(fileInput).val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg','jpeg','bmp']) == -1) {
			alert("등록 할수 없는 확장자입니다.");
			$(fileInput).val("");
		return;
		}
		
	var file = fileInput.files[0];
	var _URL = window.URL || window.webkitURL;
	var img = new Image();
	
	img.src = _URL.createObjectURL(file);
	img.onload = function(){
		
		if(img.width > 500 || img.height > 500){
			alert("이미지 크기는 500*500 이하만 가능합니다.")
			$(fileInput).val("");
		}
	}
		
}

</script>
<title>글작성</title> 
</head>
<body>

<form name="form" method="post" enctype="multipart/form-data">
	작성자: <input type="text" name="memName" value=${detailMap.memName }><br>
	ID: <input type="text" name="memId" value=${detailMap.memId }><br>
	제목: <input type="text" name="boardSubject" value=${detailMap.boardSubject }><br>
	내용:<textarea rows="5" cols="30" name="boardContent">${detailMap.boardContent }</textarea><br>
	
	
	<div>
		<c:choose>
			<c:when test="${empty detailMap }">
				<div id="fileDv">
			 		<input type="button" name="fileAdd" id="fileAdd" value=파일추가>
				</div>
			 	<input type="submit" value="등록" onclick="javascript:form.action='/insert';">
			</c:when>
			<c:otherwise>
				<div id="fileDetail">
					업로드한 파일: <br>
					<c:forEach items="${fileMap }" var="fileList">
						<a href="down?realName=${fileList.REAL_NAME }&saveName=${fileList.SAVE_NAME }">${fileList.REAL_NAME }</a><br>
					</c:forEach>
				</div>
				<input type ="hidden" name="seq" id="seq" value=${detailMap.seq }>
				<input type="submit" value="수정" onclick="javascript:form.action='/update';">
			</c:otherwise>
		</c:choose>
	</div>

	<input type="button" onclick="location.href='/list'" value="취소">
</form>

</body>
</html>