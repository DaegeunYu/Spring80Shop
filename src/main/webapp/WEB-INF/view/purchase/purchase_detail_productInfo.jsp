<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="purchase_product_info_area">
    <div class="purchase_basket_container"> 
   	 <h3 style="margin-bottom: 20px;">주문 상품 정보</h3>
    	<c:forEach var="item" items="${purchaseList}">
    		<c:set var="totalSum" value="${totalSum + (item.product.sale_price * item.basket.product_count)}" />
            <div class="purchase_basket_item"> 
            	<input type="hidden" name="product_code" id="product_code" value="${item.product.product_code}">
                <input type="hidden" name="productName" id="productName" value="${item.product.product_name}">
                <input type="hidden" name="productWeight" id="productWeight" value="${item.basket.product_weight}">
                <input type="hidden" name="product_count" id="product_count" value="${item.basket.product_count}">
                <input type="hidden" name="crushing" id="crushing" value="${item.basket.crushing}">
                <input type="hidden" name="total_price" id="total_price" value="${item.product.sale_price * item.basket.product_count}">

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
 </div>   
 
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", async function() {
    // 1. URL 파라미터 추출
    const urlParams = new URLSearchParams(window.location.search);
    const weight = urlParams.get('product_weight');
    const count = parseInt(urlParams.get('product_count')) || 1;
    const pCode = urlParams.get('product_code');
    const crushingRaw = urlParams.get('crushing');

    // 2. 분쇄도 한글 치환 및 화면 즉시 갱신
    if (crushingRaw) {
        let crushingKor = "";
        switch (crushingRaw) {
            case "notchushing": crushingKor = "분쇄 안함"; break;
            case "handdrip":    crushingKor = "핸드드립"; break;
            case "aeropress":   crushingKor = "에어로프레스"; break;
            case "dutch":       crushingKor = "더치"; break;
            case "mokapot":     crushingKor = "모카포트"; break;
            case "espresso":    crushingKor = "에스프레소"; break;
            default:            crushingKor = decodeURIComponent(crushingRaw);
        }
        
        const crushingDisplay = document.querySelector('.purchase_product_infomation p:nth-child(2) span:last-child');
        if(crushingDisplay) crushingDisplay.innerText = crushingKor;
        
        const hiddenCrushing = document.querySelector('input[name="crushing"]');
        if(hiddenCrushing) hiddenCrushing.value = crushingKor;
        
    }

    // 수량(개 수) 텍스트 갱신
    const countDisplay = document.querySelector('.purchase_product_infomation p:nth-child(3) span:last-child');
    if(countDisplay) countDisplay.innerText = count + " 개";

    // 무게별 가격 서버 요청 및 전체 금액 영역 갱신
    if (weight && pCode) {
        try {
            const url = "${path}/product/get_price.do?product_code=" + pCode + "&product_weight=" + weight;
            const response = await fetch(url);
            
            if (response.ok) {
                const singlePrice = parseInt(await response.text());
                const totalPrice = singlePrice * count;

                // 개별 상품 정보 박스 내 가격 
                const priceDetailSpan = document.querySelector('.purchase_price_detail span');
                if(priceDetailSpan) {
                    priceDetailSpan.innerHTML = "상품 금액 : " + totalPrice.toLocaleString() + " 원";
                }

                // 상품 금액 
                const summaryPriceTarget = document.querySelector('.purchase_price_detail_total span:nth-child(2)');
                if(summaryPriceTarget) {
                    summaryPriceTarget.innerText = totalPrice.toLocaleString() + " 원";
                }

                // 최종 결제 금액
                const finalPriceTarget = document.getElementById('purchase_final_total_price');
                if(finalPriceTarget) {
                    finalPriceTarget.innerText = (totalPrice + 5000).toLocaleString() + "원";
                }

                // 서버 전송용 히든 필드 값 동기화
                const hiddenPrice = document.getElementById('total_price');
                if(hiddenPrice) hiddenPrice.value = totalPrice;
            }
        } catch (error) {
            console.error("가격 데이터 동적 로드 실패:", error);
        }
    }
});
</script>
  