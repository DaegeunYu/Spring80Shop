<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
		<H2> 주문 결제 </H2>
		
			        
			<div id="purchase_info" align="center">
				<c:import url="/WEB-INF/view/purchase/purchase_detail_address.jsp" />
				<hr>
				<c:import url="/WEB-INF/view/purchase/purchase_detail_productInfo.jsp" />
				<hr>
				<c:import url="/WEB-INF/view/purchase/purchase_detail_payment.jsp" />
				<hr>
				
				
			</div>
			
		</div>
	
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />