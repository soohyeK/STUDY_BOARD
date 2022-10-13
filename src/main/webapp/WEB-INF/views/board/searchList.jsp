<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>    

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