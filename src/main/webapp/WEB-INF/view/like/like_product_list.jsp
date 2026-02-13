<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <BR>
		<H2> 찜 리스트 </H2>
		<BR>
		<div>
			<c:import url="/WEB-INF/view/like/like_product_content.jsp" /> 
		</div>		
	</div>
	<BR>
	<c:import url="/WEB-INF/view/like/like_product_paging.jsp" />
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />