<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>

	$(function() {
		
		//전체체크와 헤제
		$("#allChk").click(function() {
			if($("#allChk").is(":checked")) {
				$("[name=delChk]").prop("checked", true);
			}else{ 
				$("[name=delChk]").prop("checked", false);
				$("#result").text("");	  //
			}
		});
	
		//아이템 전체 체크도 전체체크
		$("[name=delChk]").click(function() {
			var total = $("[name=delChk]").length;
			var checked = $("[name=delChk]:checked").length;
		
			if(total != checked) {
				$("#allChk").prop("checked", false);
			}else{
				$("#allChk").prop("checked", true); 
			}
		});

		//선택 삭제 검사
		$("#delBtn").click(function(e) {
			var checked = $("[name=delChk]:checked").length;
			if (checked == 0) {
				alert("삭제할 게시물을 선택해주세요.");
			}else{ 
				e.preventDefault();
				if(!confirm("정말로 삭제하시겠습니까?")) return;
				$("#list").attr("action","delete").attr("method","post").submit();
			}
		});
		
		//검색
		$("#seBtn").click(function() {
			$.ajax({
				  url  : "searchList", //비동기는 분리
				  type : "POST",
				  data : $("#search").serialize(),
				  success : function(searchData){
				    $("#list").html(searchData);
				  },
				  error : function(){
					  alert("에러");
				  }
				});
		});		
});
	
	//페이징
	function goList(num){
		$("#pageNo").val(num);
		$("#seBtn").click();
	}
	
	
</script>
<title>게시판 만들기</title>
</head>
<body>

	<form name ="search" id = "search">
		<input type ="hidden" name = "pageNo" id = "pageNo" value ="1">
		<input type ="hidden" name = "listSize" id = "listSize" value ="20">
		<select name="seType" id="seType">
			<option value="seCho" id="seCho">선택</option>
			<option value="seMem" id="seMem"
				<c:if test="${param.seType == 'seMem'}">selected</c:if>>작성자</option>
			<option value="seSub" id="seSub"
				<c:if test="${param.seType == 'seSub'}">selected</c:if>>제목</option>
			<option value="seCon" id="seCon"
				<c:if test="${param.seType == 'seCon'}">selected</c:if>>제목+내용</option>
		</select>
		<input type="text" name="seValue" id="seValue" value="${param.seValue}">
		<input type="button" name="seBtn" id="seBtn" value="검색">
		<div>
			<input type="date" name="seDateS" id="seDateS" value="${param.seDateS}"> ~ <input type="date" name="seDateE" id="seDateE" value="${param.seDateE}">
		</div>
	</form>
	
	
	<div>
		<input type="button" onclick="location.href='/reg'" value="글쓰기">
		<input type="button" name="delBtn" id="delBtn" value="삭제">
	</div>
	<br>
	
	
	<form name ="list" id = "list">
		<table border="1">
			<tr>
				<th><input type="checkbox" name="allChk" id="allChk"></th>
				<th>글번호</th>
				<th>작성자(ID)</th>
				<th>제목</th>
				<th>작성일</th>
				<th>수정일</th>
				<th>조회수</th>
			</tr>
			
			<c:forEach items="${list }" var = "list">
			<tr>
			<td><input type="checkbox" name="delChk" id="delChk" value="${list.seq }"></td>
			<td>${list.seq }</td>
			<td>${list.memName }(${list.memId })</td> 
			<td><a href="detail?seq=${list.seq }" >"${list.boardSubject }"</a></td>
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regDate }"/></td> 
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.uptDate }"/></td> 
			<td>${list.viewCnt }</td>
			</tr>
			</c:forEach>
	
	        <tr>
	            <td colspan="7">
	                <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
	                <c:if test="${pageVO.curBlock > 1}">
	                    <a href="javascript:goList('1')">[처음]</a>
	                </c:if>
	                
	                <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageVO.curBlock > 1}">
	                    <a href="javascript:goList('${pageVO.prevPage}')">[이전]</a>
	                </c:if>
	                
	                <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
	                <c:forEach var="num" begin="${pageVO.blockBegin}" end="${pageVO.blockEnd}">
	                    <!-- **현재페이지이면 하이퍼링크 제거 -->
	                    <c:choose>
	                        <c:when test="${num == pageVO.curPage}">
	                            <span style="color: red">${num}</span>&nbsp;
	                        </c:when>
	                        <c:otherwise>
	                            <a href="javascript:goList('${num}')">${num}</a>&nbsp;
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                
	                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageVO.curBlock <= pageVO.totBlock}">
	                    <a href="javascript:goList('${pageVO.nextPage}')">[다음]</a>
	                </c:if>
	                
	                <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageVO.curPage <= pageVO.totPage}">
	                    <a href="javascript:goList('${pageVO.totPage}')">[끝]</a>
	                </c:if>
	            </td>
	        </tr>
		</table>
	</form>


</body>
</html>
