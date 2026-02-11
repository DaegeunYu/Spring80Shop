<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<<<<<<< Updated upstream
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
=======
<section id="purchase_view_one">
    <div class="one_header_area">
        <h2>주문 상세 내역</h2>
        <p>주문번호 : <strong>${orderInfo.orderCode}</strong> | 주문일 : ${orderInfo.orderDate}</p>
    </div>

    <table class="purchase_one_table">
        <thead>
            <tr>
                <th>상품코드</th>
                <th>상품명</th>
                <th>중량</th>
                <th>수량</th>
                <th>금액</th>
                <th>상태</th>
                <th>리뷰</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="totalPrice" value="0" />
            <c:forEach var="item" items="${purchaseList}">
                <c:if test="${item.productCode ne 'DELIVERY'}">
                    <c:set var="totalPrice" value="${totalPrice + item.orderPrice}" />
                    <tr>
                        <td>${item.productCode}</td>
                        <td class="one_product_name">${item.productName}</td>
                        <td>${item.productWeight}</td>
                        <td>${item.orderCount}</td>
                        <td><fmt:formatNumber value="${item.orderPrice}" type="number"/>원</td>
                        <td class="status_complete">${item.orderStatus}</td>
                        <td>
                            <c:if test="${item.isReview eq 'n'}">
                                <input type="button" class="btn_one_review" onclick="reviewForm('${item.idx}')" value="리뷰작성">
                            </c:if>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${item.productCode eq 'DELIVERY'}"><c:set var="delivery" value="${item.paidAmount}" /></c:if>
            </c:forEach>
        </tbody>
    </table>

    <div class="purchase_one_info_box">
        <h3>배송 및 결제 정보</h3>
        <p><strong>수령인 :</strong> ${orderInfo.receiverName}</p>
        <p><strong>연락처 :</strong> ${orderInfo.receiverPhone}</p>
        <p><strong>배송지 :</strong> ${orderInfo.address}</p>
        <p><strong>결제수단 :</strong> ${orderInfo.paymentMethod}</p>
        <hr class="one_hr">
        <div class="one_price_summary">
            최종 결제 금액 <span><fmt:formatNumber value="${totalPrice + delivery}" type="number"/>원</span>
        </div>
    </div>

    <div class="one_bottom_area">
        <input type="button" class="btn_one_back" onclick="location.href='${path}/purchase/purchaseList.do'" value="목록으로">
    </div>
</section>

<c:import url="/WEB-INF/view/include/bottom.jsp" />

<script>
function reviewForm(idx) {
	location.href="${path}/review/reviewForm.do?idx="+idx;
}

>>>>>>> Stashed changes
</script>