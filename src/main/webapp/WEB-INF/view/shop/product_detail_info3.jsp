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

<div class="product_detail" id="prices">
    <div class="info_title">
		가격
	</div>
	<div class="info_detail">
		<span id="price">0</span>원					
	</div>
</div>

<BR>
<hr>
<BR>

<div class="purchase_button">
	<div>
		<a class="button" id="buyNow" href="#">바로구매</a>
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
	
	const priceDisplay = document.getElementById('price');
	const weightSelect = document.getElementById('weight');
	const productCode = "${param.product_code}";
	
	let price = 0;
	
	async function fetchPriceFromServer() {
	    const selectedWeight = weightSelect.value;
	    const count = parseInt(countInput.value) || 1;

	    // '선택 안함'일 경우 0원 처리
	    if (selectedWeight === 'not') {
	        priceDisplay.innerText = '0';
	        return;
	    }
	    
	    try {
	        // 서버의 Controller로 상품코드와 무게를 보냄
	        const url = "${path}/product/get_price.do?product_code=" + productCode + "&product_weight=" + selectedWeight; 
	        const response = await fetch(url);
	        
	        if (response.ok) {
	        	const priceText = await response.text(); 
	            price = parseInt(priceText);

	            if (!isNaN(unitPrice)) {
	                const totalPrice = price * count;
	                priceDisplay.innerText = totalPrice.toLocaleString();
	            }
	        }
	    } catch (error) {
	        console.error("가격 정보를 가져오는데 실패했습니다.", error);
	    }
	}

	// 이벤트 연결: 무게 변경 시 서버 요청
	weightSelect.addEventListener('change', fetchPriceFromServer);

	// 수량 버튼 클릭 시에도 호출 (기존 코드에 추가)
	upBtn.addEventListener('click', () => {
        let current = parseInt(countInput.value);
        countInput.value = current + 1;
        fetchPriceFromServer(); 
    });
	
	downBtn.addEventListener('click', () => {
	    let current = parseInt(countInput.value);
	    if (current > 1) {
	        countInput.value = current - 1;
	        fetchPriceFromServer();
	    }
	});
	
	document.getElementById('buyNow').addEventListener('click', function(e) {
	    e.preventDefault();

	    const crushingSelect = document.getElementById('crushing');
	    const weightSelect = document.getElementById('weight');
	    const productCount = document.getElementById('product_count');
	    
	    // 유효성 검사 (옵션 선택 여부)
	    if (crushingSelect.value === 'not') { alert('분쇄도를 선택해 주세요.'); crushingSelect.focus(); return; }
	    if (weightSelect.value === 'not') { alert('무게를 선택해 주세요.'); weightSelect.focus(); return; }

	    // 최종 URL 구성
	    const url = "${path}/purchase/purchase.do?product_code=${product.product_code}" +
	                "&product_count=" + productCount.value +
	                "&crushing=" + crushingSelect.value +
	                "&product_weight=" + weightSelect.value;
	 	// 3. 페이지 이동
	    location.href = url;
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
        "&product_count=" + selectedCount +
        "&basket_price=" + price;
	    
	    // 3. 페이지 이동
	    location.href = finalUrl;
	});
</script>

