<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <BR>
		<H2> 구매 내역 </H2>
		<BR>
		<table border=1>
			<tr>
				<td>주문번호</td> <!-- 1. order_code -->
				<td>아이디</td> <!-- 2. user_id -->
				<td>상품코드</td> <!-- 3. product_code -->
				<td>상품명</td> <!-- 4. product_name -->
				<td>상품중량</td> <!-- 5. product_weight -->
				<td>분쇄도</td> <!-- 6. crushing -->
				
				<td>주문수량</td> <!-- 7. order_count -->
				<td>주문금액</td> <!-- 8. order_price -->
				<td>주문일</td> <!-- 9. order_date -->
				<td>주문상태</td> <!-- 10. order_status -->
				
				<td>리뷰</td> <!-- 11. is_review -->
			</tr>
			<c:forEach var="li" items="${purchaseList}">
				<tr>
					<td>${li.orderCode}</td>
					<td>${li.userId}</td>
					<td>${li.productCode}</td>
					<td>${li.productName}</td>
					<td>${li.productWeight}</td>
					<td>${li.crushing}</td>
					<td>${li.orderCount}</td>
					<td>${li.orderPrice}</td>
					<td>${li.orderDate}</td>
					<td>${li.orderStatus}</td>
					<td>
						<c:choose>
						    <c:when test="${li.isReview eq 'n'}">						        
						        <input type="button" onclick="reviewForm('${li.orderCode}', '${li.productCode}')" value="리뷰작성">						       
						    </c:when>
						    <c:otherwise>
						        <input type="button" onclick="reviewCheck('${li.orderCode}', '${li.productCode}')" value="리뷰확인">
						    </c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
  
		<BR>
		
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />
<script>
    function reviewForm(oCode, pCode){
        location.href="${path}/review/reviewForm.do?orderCode=" + oCode + "&productCode=" + pCode;
    }
    function reviewCheck(oCode, pCode){
        location.href="${path}/review/reviewCheck.do?orderCode=" + oCode + "&productCode=" + pCode;
    }
</script>