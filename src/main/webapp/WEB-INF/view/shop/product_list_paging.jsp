<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:if test="${type=='is'}">
	
</c:if>



<div class="pagination-container">
    <ul class="pagination">
		        <c:if test="${current_page > 1}">
		            <li><a href="?is_single_origin=${value}&page=1">&laquo; 처음으로</a></li>
		        </c:if>
		
		        <c:if test="${prev}">
		            <li><a href="?is_single_origin=${value}&page=${start_page - 1}">이전</a></li>
		        </c:if>
		
		        <c:forEach begin="${start_page}" end="${end_page}" var="idx">
		            <li class="${current_page == idx ? 'active' : ''}">
		                <a href="?is_single_origin=${value}&page=${idx}">${idx}</a>
		            </li>
		        </c:forEach>
		
		        <c:if test="${next}">
		            <li><a href="?is_single_origin=${value}&page=${end_page + 1}">다음</a></li>
		        </c:if>
		
		        <c:if test="${current_page < total_page}">
		            <li><a href="?is_single_origin=${value}&page=${total_page}">끝으로 &raquo;</a></li>
		        </c:if>
		    </ul>
    
    
    <%-- <c:choose>
		<c:when test="${type=='is'">
						
		</c:when>
		<c:otherwise>
			<ul class="pagination">
		        <c:if test="${current_page > 1}">
		            <li><a href="?page=1">&laquo; 처음으로</a></li>
		        </c:if>
		
		        <c:if test="${prev}">
		            <li><a href="?page=${start_page - 1}">이전</a></li>
		        </c:if>
		
		        <c:forEach begin="${start_page}" end="${end_page}" var="idx">
		            <li class="${current_page == idx ? 'active' : ''}">
		                <a href="?page=${idx}">${idx}</a>
		            </li>
		        </c:forEach>
		
		        <c:if test="${next}">
		            <li><a href="?page=${end_page + 1}">다음</a></li>
		        </c:if>
		
		        <c:if test="${current_page < total_page}">
		            <li><a href="?page=${total_page}">끝으로 &raquo;</a></li>
		        </c:if>
		    </ul>
		</c:otherwise>
	</c:choose> --%>
    
</div>
