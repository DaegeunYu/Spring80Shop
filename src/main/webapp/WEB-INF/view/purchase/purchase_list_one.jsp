<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/view/include/top.jsp" />
<link rel="stylesheet" href="${path}/resources/css/purchase.css">

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
            <c:set var="delivery" value="0" />
            
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
                            <c:choose>
							    <%-- 결제대기 상태일 때 --%>
						        <c:when test="${item.orderStatus eq '결제대기'}">
						            <span class="status_pending">결제진행중</span>
						        </c:when>
						        
						        <%-- 결제완료이면서 리뷰를 작성하지 않았을 때 --%>
						        <c:when test="${item.orderStatus eq '결제완료' and item.isReview eq 'n'}">
						            <input type="button" class="btn_review write" onclick="reviewForm('${item.idx}')" value="리뷰작성">
						        </c:when>
						        
						        <%-- 결제완료이면서 리뷰를 이미 작성했을 때 (isReview eq 'y') --%>
						        <c:when test="${item.orderStatus eq '결제완료' and item.isReview eq 'y'}">
						            <input type="button" class="btn_review view" onclick="reviewView('${item.idx}', '${item.productCode}', '${item.orderCode}')" value="리뷰확인">
						        </c:when>
							</c:choose>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${item.productCode eq 'DELIVERY'}"><c:set var="delivery" value="${item.orderPrice}" /></c:if>
            </c:forEach>
        </tbody>
    </table>

    <div class="purchase_one_info_box">
        <h3>배송 및 결제 정보</h3>
        <p><strong>수령인 :</strong> ${orderInfo.receiverName}</p>
        <p><strong>연락처 :</strong> ${orderInfo.receiverPhone}</p>
        <p><strong>배송지 :</strong> ${orderInfo.address}</p>
        <p><strong>결제수단 :</strong> ${orderInfo.paymentMethod}</p>
        <p><strong>배송비 :</strong> <fmt:formatNumber value="${delivery_price}" type="number"/>원</p>
        <hr class="one_hr">
        <div class="one_price_summary">
            최종 결제 금액 <span><fmt:formatNumber value="${totalPrice + delivery_price}" type="number"/>원</span>
        </div>
    </div>

    <div class="one_bottom_area">
        <input type="button" class="btn_one_back" onclick="location.href='${path}/purchase/purchaseList.do'" value="목록으로">
    </div>
</section>
<script>
function reviewForm(idx) {
    location.href="${path}/review/reviewForm.do?idx="+idx;
}
function reviewView(idx) {
	const url = "${pageContext.request.contextPath}/review/reviewDetail2.do?idx=" + idx;
	const options = "width=700, height=800, top=100, left=200, resizable=yes, scrollbars=yes";
	window.open(url, "ReviewDetail_" + idx, options);
}

</script>

<c:import url="/WEB-INF/view/include/bottom.jsp" />