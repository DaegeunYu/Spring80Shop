<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/WEB-INF/view/include/top.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/purchase.css">

<div id="purchase_info">
	<div class="success_header">
		<h2>주문이 완료되었습니다!</h2>
		<p class="order_code_text">
			주문번호 : <strong>${orderInfo.orderCode}</strong>
		</p>
	</div>

	<div class="address_area">
		<h3>배송지 정보</h3>
		<div class="addr_box">
			<p>
				<strong>받는 사람 :</strong> ${orderInfo.receiverName}
			</p>
			<p>
				<strong>연락처 :</strong> ${orderInfo.receiverPhone}
			</p>
			<p>
				<strong>배송지 :</strong> ${orderInfo.address}
			</p>
			<p>
				<strong>배송 메모 :</strong> ${empty orderInfo.orderMemo ? '요청사항 없음' : orderInfo.orderMemo}
			</p>
		</div>
	</div>

	<div class="purchase_basket_container">
		<h3>주문 상품 정보</h3>
		<c:forEach var="item" items="${orderItems}">
			<div class="purchase_basket_item">
				<div class="purchase_image_box">
					<img src="${item.product.product_img}"
						class="purchase_product_image">
				</div>

				<div class="purchase_product_name">
					<strong>${item.product.product_name}</strong>
				</div>

				<div class="purchase_product_infomation">
					<p>
						<span>중량</span> <span>: ${item.purchase.productWeight}</span>
					</p>
					<p>
						<span>분쇄</span> <span>: ${item.purchase.crushing}</span>
					</p>
					<p>
						<span>개수</span> <span>: ${item.purchase.orderCount}개</span>
					</p>
					<p>
						<span>금액</span> <span>: <fmt:formatNumber
								value="${item.purchase.orderPrice}" pattern="#,###" /> 원
						</span>
					</p>
				</div>
			</div>
		</c:forEach>
	</div>

	<div class="purchase_summary_box">
		<div class="purchase_price_detail">
			<span>상품 합계 : </span> <span class="purchase_price_detail_total">
				<fmt:formatNumber value="${finalPrice - 5000}" pattern="#,###" />원
			</span>
		</div>
		<div class="purchase_price_detail">
			<span>배송비 : </span> <span class="purchase_delivery_price">
				5,000원</span>
		</div>
		<div class="purchase_price_detail">
			<span>결제 상태 : </span> <span class="purchase_price_detail_total">
				<c:choose>
					<c:when
						test="${orderInfo.paymentMethod eq 'CARD'}">
						<span class="status_complete"> 결제완료 </span>
					</c:when>
					<c:when
						test="${orderInfo.paymentMethod eq 'BANK'}">
						<span class="status_wait">결제대기 (입금 확인 중)</span>
					</c:when>
					<c:otherwise>
                    ${orderInfo.orderStatus} </c:otherwise>
				</c:choose>
			</span>
		</div>

		<div class="purchase_price_total">
			최종 결제 금액 <strong><fmt:formatNumber value="${finalPrice}"
					pattern="#,###" />원</strong>
		</div>
	</div>

	<div class="success_btn_area">
		<button type="button" class="btn_payment btn_white"
			onclick="location.href='${pageContext.request.contextPath}/index.do'">쇼핑
			계속하기</button>
		<button type="button" class="btn_payment btn_black"
			onclick="location.href='${pageContext.request.contextPath}/purchase/purchaseList.do'">주문내역
			확인</button>
	</div>
</div>

<c:import url="/WEB-INF/view/include/bottom.jsp" />