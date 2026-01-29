<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<BR>

<div class="product_detail">
	<div class="info_title">
		분쇄 선택 *
	</div>
	<div class="info_detail">
		<select name="crushing" id="crushing">
		    <option value="not">선택 안함</option>
		    <option value="notchushing">분쇄 안함</option>
		    <option value="handdrip">핸드드립</option>
		    <option value="aeropress">에어로프레스</option>
		    <option value="dutch">더치</option>
		    <option value="mokapot">모카포트</option>
		    <option value="espresso">에스프레소</option>
		 </select>						
	</div>
</div>
<BR>
<div class="product_detail">
	<div class="info_title">
		무게 선택 *
	</div>
	<div class="info_detail">
		<select name="weight" id="weight">
		    <option value="not">선택 안함</option>
		    <option value="200g">200g</option>
		    <option value="350g">350g</option>
		    <option value="500g">500g</option>
		    <option value="1000g">1Kg</option>
		 </select>						
	</div>
</div>
<BR>
<div class="product_detail">
    <div class="info_title">
		수량
	</div>
	<div class="info_detail">
		<div class="quantity-stepper">
		    <input type="text" id="product_count" class="product_count" value="1" readonly>
		    
		    <div class="button-container">
		        <button type="button" class="count-btn up-btn">▲</button>
		        <button type="button" class="count-btn down-btn">▼</button>
		    </div>
		</div>					
	</div>
</div>

<BR>
<hr>
<BR>

<div class="purchase_button">
	<div>
		<a class="button" href=${path}/purchase/purchase.do?product_code=${product.product_code}>바로구매</a>
	</div>
	<div>
		<a class="button" id="addToBasket" href="#">장바구니</a>
	</div>
	<div class="icon_box">
		<img class="icon" src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/icn_heart_empty.png"> <!-- PJ TODO: 찜하기 버튼 변경 추후 추가 -->
	</div>
</div>
<BR>

<script>
	const upBtn = document.querySelector('.up-btn');
    const downBtn = document.querySelector('.down-btn');
	const countInput = document.querySelector('.product_count');
	
    upBtn.addEventListener('click', () => {
        let current = parseInt(countInput.value);
        countInput.value = current + 1;
    });
	
	downBtn.addEventListener('click', () => {
	    let current = parseInt(countInput.value);
	    if (current > 1) {
	        countInput.value = current - 1;
	    }
	});
	
	document.getElementById('addToBasket').addEventListener('click', function(e) {
	    e.preventDefault(); // 기본 링크 이동 막기

	    const weightSelect = document.getElementById('weight');
	    const crushingSelect = document.getElementById('crushing');
	    const productCount = document.getElementById('product_count');
	    const selectedWeight = weightSelect.value;
	    const selectedCrushing = crushingSelect.value;
	    const selectedCount = productCount.value;
	    const productCode = "${product.product_code}"; // 서버에서 받아온 코드
	    const path = "${path}"; // 서버 기본 경로

	    // 1. 유효성 검사 (선택 안함 방지)
	    if (selectedCrushing === 'not') {
	    	alert('분쇄도를 선택해 주세요.');
	    	crushingSelect.focus();
	        return;
	    }
	    
	    if (selectedWeight === 'not') {
	        alert('무게를 선택해 주세요.');
	        weightSelect.focus();
	        return;
	    }
	    
	    fincrushing = "";
	    
	    switch (selectedCrushing) {
	    case "notchushing":
	    	fincrushing = "분쇄 안함";
	        break;
	    case "handdrip":
	    	fincrushing = "핸드드립";
	        break;
	    case "aeropress":
	    	fincrushing = "에어로프레스";
	        break;
	    case "dutch":
	    	fincrushing = "더치";
	        break;
	    case "mokapot":
	    	fincrushing = "모카포트";
	        break;
	    default:
	    	fincrushing = "에스프레소";
		}
	    
	    // 2. 최종 URL 구성
	    const finalUrl = path + "/basket/basket_in.do?product_code=" + productCode + 
        "&crushing=" + fincrushing +
        "&product_weight=" + selectedWeight + 
        "&product_count=" + selectedCount;
	    
	    // 3. 페이지 이동
	    location.href = finalUrl;
	});
</script>

