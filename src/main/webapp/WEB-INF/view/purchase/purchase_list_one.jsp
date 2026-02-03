<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <BR>
		<H2> 세부 구매 내역  <br> 주문번호 : ${purchaseOne.orderCode} </H2>
		<BR>
		
		<table border=1>
			<tr>	
				<td>아이디</td> <!-- 2. user_id -->
				<td>${purchaseOne.userId}</td>
			</tr>	
			<tr>	
				<td>상품코드</td> <!-- 3. product_code -->
				<td>${purchaseOne.productCode}</td>
			</tr>	
			<tr>	
				<td>상품명</td> <!-- 4. product_name -->
				<td>${purchaseOne.productName}</td>
			</tr>	
			<tr>
				<td>상품중량</td> <!-- 5. product_weight -->
				<td>${purchaseOne.productWeight}</td>
			</tr>	
			<tr>	
				<td>분쇄도</td> <!-- 6. crushing -->
				<td>${purchaseOne.crushing}</td>
			</tr>	
			<tr>	
				<td>주문수량</td> <!-- 7. order_count -->
				<td>${purchaseOne.orderCount}</td>
			</tr>	
			<tr>	
				<td>주문금액</td> <!-- 8. order_price -->
				<td>${purchaseOne.orderPrice}</td>
			</tr>	
			<tr>	
				<td>주문일</td> <!-- 9. order_date -->
				<td>${purchaseOne.orderDate}</td>
			</tr>	
			<tr>	
				<td>주문상태</td> <!-- 10. order_status -->
				<td>${purchaseOne.orderStatus}</td>
			</tr>
		</table>
		<br>
		<input type="button" onClick="purchaseList()" value="구매리스트">
  		
		<BR>
		
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />
<script>
	function purchaseList() {
		location.href="${path}/purchase/purchaseList.do"
	}
</script>