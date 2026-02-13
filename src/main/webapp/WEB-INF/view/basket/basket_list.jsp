<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <BR>
		<H2> 장바구니 </H2>
		<BR>
		<div>
			<c:import url="/WEB-INF/view/basket/basket_list_content.jsp" /> 
		</div>		
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />