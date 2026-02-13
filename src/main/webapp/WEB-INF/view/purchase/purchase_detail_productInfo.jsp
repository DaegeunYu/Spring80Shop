<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="purchase_product_info_area">
    <div class="purchase_basket_container"> 
   	 <h3 style="margin-bottom: 20px;">주문 상품 정보</h3>
    	<c:forEach var="item" items="${purchaseList}">
            <div class="purchase_basket_item"> 
            	<input type="hidden" name="product_code"  value="${item.product.product_code}">
                <input type="hidden" name="productWeight"  value="${item.basket.product_weight}">
                <input type="hidden" name="product_count"  value="${item.basket.product_count}">
                <input type="hidden" name="crushing"  value="${item.basket.crushing}">

                <div class="purchase_image_box">
                    <img class="purchase_product_image" src="${pageContext.request.contextPath}/resources/files/${item.product.product_img}">
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
        			<span><fmt:formatNumber value="${total_price}" pattern="#,###" /> 원</span>
   				</div>
       			<div class="purchase_delivery_price">
           			<span>배송비 : 5,000원</span>
       			</div>
       			<div class="purchase_price_total">
           			<span>총 결제 금액 : </span>
           			<strong id="purchase_final_total_price">
           			 	<fmt:formatNumber value="${final_total_price}" pattern="#,###" />원
           			</strong>
       			</div>
           	</div>
    </div>  
 </div>   
 
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", async function() {
    // URL 파라미터 추출
    const urlParams = new URLSearchParams(window.location.search);
    const crushingRaw = urlParams.get('crushing');

    // 분쇄도 한글 치환 및 화면 즉시 갱신
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

  
});
</script>
  