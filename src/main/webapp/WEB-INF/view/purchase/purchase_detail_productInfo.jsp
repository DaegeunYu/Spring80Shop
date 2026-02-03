<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="product_info_area">
    <h3 style="margin-bottom: 20px;">주문 상품 정보</h3>
    
    <div class="basket_container"> 
    	<c:forEach var="item" items="${purchaseList}">
            <div class="basket_item"> 
            	<input type="hidden" name="product_code" value="${item.product.product_code}">
                <input type="hidden" name="productName" value="${item.product.product_name}">
                <input type="hidden" name="productWeight" value="${item.basket.product_weight}">
                <input type="hidden" name="crushing" value="${item.basket.crushing}">
                <input type="hidden" name="product_count" value="${item.basket.product_count}">
                <input type="hidden" name="total_price" value="${item.product.sale_price * item.basket.product_count}">

                <div class="image_box">
                    <img class="product_image" src="${item.product.product_img}">
                </div>

                <div class="product_name">
                    <strong>${item.product.product_name}</strong>
                </div>

                <div class="product_infomation">
                    <p><span> 중 량 : </span> <span> ${item.basket.product_weight} </span></p>
                    <p><span> 분 쇄 : </span> <span> ${item.basket.crushing} </span></p>
                    <p><span> 개 수 : </span> <span> ${item.basket.product_count} 개 </span></p>
                    <p>
                        <span> 가 격 : </span> 
                        <span> 
                            <fmt:formatNumber value="${item.product.sale_price * item.basket.product_count}" pattern="#,###" /> 원 
                        </span>
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<style>
    /* 장바구니(basket_list) 스타일이 이 페이지에 없을 경우를 대비한 최소한의 가이드 */
    .basket_item {
        display: flex;
        align-items: center;
        border-bottom: 1px solid #eee;
        padding: 15px 0;
    }
    .image_box img { width: 100px; margin-right: 20px; }
    .product_name { flex: 1; }
    .product_infomation { flex: 1; text-align: right; line-height: 1.6; }
    .product_infomation p span:first-child { color: #888; margin-right: 10px; }
</style>