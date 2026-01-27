<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <BR>
		<H2> 구매 페이지 </H2>
		<BR>
		<BR>
		<div> ${product.product_name} </div>		
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />