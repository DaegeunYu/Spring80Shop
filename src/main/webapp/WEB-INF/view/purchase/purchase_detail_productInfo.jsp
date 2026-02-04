<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="purchase_product_info_area">
    
    
    <div class="purchase_basket_container"> 
   	 <h3 style="margin-bottom: 20px;">주문 상품 정보</h3>
    	<c:forEach var="item" items="${purchaseList}">
    		<c:set var="totalSum" value="${totalSum + (item.product.sale_price * item.basket.product_count)}" />
            <div class="purchase_basket_item"> 
            	<input type="hidden" name="product_code" value="${item.product.product_code}">
                <input type="hidden" name="productName" value="${item.product.product_name}">
                <input type="hidden" name="productWeight" value="${item.basket.product_weight}">
                <input type="hidden" name="crushing" value="${item.basket.crushing}">
                <input type="hidden" name="product_count" value="${item.basket.product_count}">
                <input type="hidden" name="total_price" value="${item.product.sale_price * item.basket.product_count}">

                <div class="purchase_image_box">
                    <img class="purchase_product_image" src="${item.product.product_img}">
                </div>

                <div class="purchase_product_name">
                    <strong>${item.product.product_name}</strong>
                </div>

                <div class="purchase_product_infomation">
                    <p><span> 중 량 : </span> <span> ${item.basket.product_weight} </span></p>
                    <p><span> 분 쇄 : </span> <span> ${item.basket.crushing} </span></p>
                    <p><span> 개 수 : </span> <span> ${item.basket.product_count} 개 </span></p>
                   
                     <div class="purchase_price_detail">
            			<span>상품 금액 : <fmt:formatNumber value="${item.product.sale_price * item.basket.product_count}" pattern="#,###" /> 원 </span>
                   	 </div>
              	</div>
			</div>
               
        </c:forEach>
        	<div class="purchase_summary_box">
        		<div class="purchase_price_detail_total">
        			<span>상품 금액 : </span>
        			<span><fmt:formatNumber value="${totalSum}" pattern="#,###" /> 원</span>
   				</div>
       			<div class="purchase_delivery_price">
           			<span>배송비 : 5,000원</span>
       			</div>
       			<div class="purchase_price_total">
           			<span>총 결제 금액 : </span>
           			<strong id="purchase_final_total_price">
           			 	<fmt:formatNumber value="${totalSum + 5000}" pattern="#,###" />원
           			</strong>
       			</div>
           	</div>
    </div>    
  