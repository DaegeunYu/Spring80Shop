<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<BR>

<div class="purchase_button">
	<div>
		<a class="button" href=${path}/purchase/purchase.do?product_code=${product.product_code}>구매하기</a>
	</div>
	<div>
		<a class="button" href=${path}/purchase/purchase.do?product_code=${product.product_code}>장바구니</a>
	</div>
	<div>
		<img src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/icn_heart_empty.png"> <!-- PJ TODO: 찜하기 버튼 변경 추후 추가 -->
	</div>
</div>
<BR>