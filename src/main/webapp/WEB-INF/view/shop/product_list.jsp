<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section class="list_section">
	<div align="center">
        <BR>
		<H2>
			<c:choose>
			    <c:when test="${param.is_single_origin eq 'y'}">
			    	싱글 오리진 리스트
	        	</c:when>
			    <c:otherwise>
			        블렌드 리스트
			    </c:otherwise>
			</c:choose>
		</H2>		
			<c:import url="/WEB-INF/view/shop/product_list_content.jsp" />
		<BR> 
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />