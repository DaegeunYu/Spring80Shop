<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="puchase_link_container">
    <div class="total_price_area">
        <div class="price_detail">
            <span>상품 금액 : </span>
            <span id="sum_price">0</span>원
        </div>
        <div class="price_detail">
            <span>배송비 : </span>
            <span id="delivery_price">5,000</span>원
        </div>
        <div class="price_total">
            <span>총 결제 금액 : </span>
            <strong id="final_total_price">5,000</strong>원
        </div>
    </div>
    
    <div class="purchase_button_area">
        <button type="button" class="btn_purchase">
            총 <span id="purchase_count">0</span>개 상품 구매하기
        </button>
    </div>
</div>

<div class="basket_container">
	
	<div class="basket_control_bar">
        <div class="all_check_area">
            <input type="checkbox" id="all_check" checked>
            <label for="all_check">전체 선택 (<span id="checked_count">0</span> / ${basket_list.size()})</label>
        </div>
        <button type="button" class="btn_delete_selected">선택삭제</button>
    </div>

	<c:forEach var="m" items="${basket_list}">
		<div class="basket_item">
			<div class="check_box">
                <input type="checkbox" name="select_item"
                 value="${m.product_code}"
                 data-idx="${m.idx}"
                 data-id="${m.user_id}"
                 data-code="${m.product_code}"
                 data-name="${m.product_name}"
                 data-img="${m.product_img}"
                 data-weight="${m.product_weight}"
                 data-crushing="${m.crushing}"
                 data-price="${m.basket_price}" 
       		     data-count="${m.product_count}"
       		     checked>
            </div>
			<div class="image_box">
				<a href="${path}/product/product_detail.do?product_code=${m.product_code}">
					<img class="product_image" src="${pageContext.request.contextPath}/resources/files/${m.product_img}">
				</a>
			</div>
			<div class="product_name">
				<strong>${m.product_name} </strong>
			</div>
			<div class="product_infomation">
				<p> <span> 중 량 : </span> <span> ${m.product_weight} </span> </p>
				<p> <span> 분 쇄 : </span> <span> ${m.crushing} </span> </p>
				<p> <span> 개 수 : </span> <span> ${m.product_count} </span> </p>
				<p> <span> 단 가 : </span> <span> <fmt:formatNumber value="${m.basket_price}" pattern="#,###" /> 원 </span> </p>
			</div>
		</div>
	</c:forEach>
</div>

<script type="text/javascript">

//OrderAmountDTO의 배송비 입력값 적용 
const SERVER_DELIVERY_FEE = <%= com.eighty.purchase.OrderAmountDTO.POLICY_DELIVERY_FEE %>;

	document.addEventListener('DOMContentLoaded', function() {
		const allCheck = document.getElementById('all_check');
	    const itemChecks = document.querySelectorAll('input[name="select_item"]');
	    const btnDelete = document.querySelector('.btn_delete_selected');
	    const btnPurchase = document.querySelector('.btn_purchase');
	    
	    const sumPriceDisplay = document.getElementById('sum_price');
	    const deliveryPriceDisplay = document.getElementById('delivery_price');
	    const finalPriceDisplay = document.getElementById('final_total_price');
	    const purchaseCountDisplay = document.getElementById('purchase_count');
	    const checkedCountDisplay = document.getElementById('checked_count');

	    // [함수] 가격 및 개수 계산 및 화면 업데이트
	    function updateCalculations() {
	        const checkedItems = document.querySelectorAll('input[name="select_item"]:checked');
	        let sumPrice = 0;
	        let totalCount = checkedItems.length;

	        checkedItems.forEach(item => {
	            // 체크박스의 data-price와 data-count 속성에서 값을 가져옴
	            const price = parseInt(item.getAttribute('data-price')) || 0;
	            const count = parseInt(item.getAttribute('data-count')) || 0;
	            sumPrice += (price * count);
	        });

	        // 상품이 0개면 배송비도 0원, 있으면 5,000원
	        
	        let deliveryFee = (totalCount === 0) ? 0 : SERVER_DELIVERY_FEE;
	        const finalTotal = sumPrice + deliveryFee;

	        // 화면에 천단위 콤마 적용하여 출력
	        sumPriceDisplay.innerText = sumPrice.toLocaleString();
	        deliveryPriceDisplay.innerText = deliveryFee.toLocaleString();
	        finalPriceDisplay.innerText = finalTotal.toLocaleString();
	        purchaseCountDisplay.innerText = totalCount;
	        checkedCountDisplay.innerText = totalCount;
	    }
	    
	    // 1. 전체 선택 클릭 이벤트
	    if (allCheck) {
	        allCheck.addEventListener('change', function() {
	            itemChecks.forEach(check => {
	                check.checked = allCheck.checked;
	            });
	            updateCalculations();
	        });
	    }

	    // 2. 개별 체크박스 클릭 이벤트
	    itemChecks.forEach(check => {
	        check.addEventListener('change', function() {
	            const checkedCount = document.querySelectorAll('input[name="select_item"]:checked').length;
	            if (allCheck) allCheck.checked = (checkedCount === itemChecks.length);
	            updateCalculations();
	        });
	    });

	    // 3. 삭제 버튼 이벤트
        btnDelete.addEventListener('click', function() {
            const selectedList = [];
            const checkedItems = document.querySelectorAll('input[name="select_item"]:checked');

            checkedItems.forEach(item => {
                selectedList.push({
                    idx: item.getAttribute('data-idx')
                });
            });

            if (selectedList.length === 0) {
                alert("삭제할 항목을 선택해주세요.");
                return;
            }

            if (confirm("정말로 삭제하시겠습니까?")) {
                fetch('${path}/basket/basket_delete.do', { 
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(selectedList)
                })
                .then(res => {
                    if(res.ok) {
                        alert("삭제 성공!");
                        location.reload();
                    } else {
                        // 여기서 서버의 에러 메시지를 확인해봅시다.
                        res.text().then(text => alert("삭제 실패 사유: " + text));
                    }
                })
                .catch(err => console.error("네트워크 에러:", err));
            }
	    });
	    
	    // 4. 구매 버튼 이벤트
        btnPurchase.addEventListener('click', function() {
            const selectedList = [];
            const checkedItems = document.querySelectorAll('input[name="select_item"]:checked');

            checkedItems.forEach(item => {
                selectedList.push({
                    idx: item.getAttribute('data-idx'),
                    user_id: item.getAttribute('data-id'),
                    product_code: item.getAttribute('data-code'),
                    product_name: item.getAttribute('data-name'),
                    product_img: item.getAttribute('data-img'),
                    product_weight: item.getAttribute('data-weight'),
                    crushing: item.getAttribute('data-crushing'),
                    product_count: item.getAttribute('data-count'),
                    basket_price: item.getAttribute('data-price')
                });
            });

            if (selectedList.length === 0) {
                alert("구매할 항목을 선택해주세요.");
                return;
            }

            if (confirm("정말로 구매하시겠습니까?")) {
            	const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${path}/purchase/purchase.do'; // 이동할 페이지의 URL (예: 주문페이지)

                // 1. JSON 데이터를 문자열로 변환하여 hidden input에 저장
                const hiddenField = document.createElement('input');
                hiddenField.type = 'hidden';
                hiddenField.name = 'jsonPayload'; // 서버에서 @RequestParam("jsonPayload")로 받을 이름
                hiddenField.value = JSON.stringify(selectedList);

                form.appendChild(hiddenField);

                // 2. 폼을 본문에 추가하고 전송
                document.body.appendChild(form);
                form.submit();
            }
	    });

	    updateCalculations(); // 초기 실행
	});
</script>
