<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
<form id="orderForm" action="${path}/purchase/purchase_insert.do" method="post" onsubmit="return orderFormOK()">
    <!-- <input type="hidden" name="product_code" value="${product.product_code}"> -->
    <!-- <input type="hidden" name="product_count" value="${product_count}">-->
    <!-- <input type="hidden" name="total_price" value="${product.sale_price * product_count}">-->
    
    <input type="hidden" name="receiverName"  id="receiverName" value="${users.user_name}">
	<input type="hidden" name="receiverPhone" id="receiverPhone"  value="${users.user_tel}">
	<input type="hidden" name="address"       id="address"  value="${users.user_add}">
    <input type="hidden" name="orderMemo" id="orderMemo" value="">
    
    <input type="hidden" name="orderCode" id="orderCode" 
       value="ORD<%= new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()) %><%= (int)(Math.random() * 1000) %>">
    <!-- <input type="hidden" name="productName" id="productName" value="${product.product_name}"> -->
    <!-- <input type="hidden" name="productWeight" id="productWeight" value="${product.quantity}">  -->
    <!-- <input type="hidden" name="crushing" value="${param.crushing}"> -->
    
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
</form>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />