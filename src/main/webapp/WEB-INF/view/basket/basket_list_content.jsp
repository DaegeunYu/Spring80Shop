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
            <span>5,000</span>원
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
            <input type="checkbox" id="all_check">
            <label for="all_check">전체 선택 (<span id="checked_count">0</span> / ${basket_list.size()})</label>
        </div>
        <button type="button" class="btn_delete_selected">선택삭제</button>
    </div>

	<c:forEach var="m" items="${basket_list}">
		<div class="basket_item">
			<div class="check_box">
                <input type="checkbox" name="select_item" value="${m.product_code}">
            </div>
			<div class="image_box">
				<a href="${path}/product/product_detail.do?product_code=${m.product_code}">
					<img class="product_image" src="${m.product_img}">
				</a>
			</div>
			<div class="product_name">
				<strong>${m.product_name} </strong>
			</div>
			<div class="product_infomation">
				<p> <span> 중 량 : </span> <span> ${m.product_weight} </span> </p>
				<p> <span> 분 쇄 : </span> <span> ${m.crushing} </span> </p>
				<p> <span> 개 수 : </span> <span> ${m.product_count} </span> </p>
			</div>
		</div>
	</c:forEach>
</div>

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		// 1. 사용할 요소들 정의
		const allCheck = document.getElementById('all_check');
	    const itemChecks = document.querySelectorAll('input[name="select_item"]');
	    const countDisplay = document.getElementById('checked_count'); // 전체선택 옆 숫자
	    const purchaseCountDisplay = document.getElementById('purchase_count'); // 버튼 안 숫자
	    const sumPriceDisplay = document.getElementById('sum_price');
	    const finalPriceDisplay = document.getElementById('final_total_price');
	    const deleteBtn = document.querySelector('.btn_delete_selected');
	    
	    // 2. [함수] 금액 및 개수 업데이트 로직
	    function updateAllStatus() {
	        const checkedItems = document.querySelectorAll('input[name="select_item"]:checked');
	        const deliveryFee = 5000;
	        let sumPrice = 0;
	        let totalCount = checkedItems.length;

	        checkedItems.forEach(item => {
	            // value 외에 data-price 속성 등을 활용해 계산 (필요시 추가)
	            const price = parseInt(item.getAttribute('data-price')) || 0;
	            const count = parseInt(item.getAttribute('data-count')) || 1;
	            sumPrice += (price * count);
	        });

	        const finalDelivery = (totalCount === 0) ? 0 : deliveryFee;
	        
	        // 화면 글자 교체
	        countDisplay.innerText = totalCount;
	        purchaseCountDisplay.innerText = totalCount;
	        sumPriceDisplay.innerText = sumPrice.toLocaleString();
	        finalPriceDisplay.innerText = (sumPrice + finalDelivery).toLocaleString();
	    }
	
	    // 3. 전체 선택 클릭 시 이벤트
	    allCheck.addEventListener('change', function() {
	        itemChecks.forEach(check => {
	            check.checked = allCheck.checked;
	        });
	    });
	
	    // 4. 개별 체크박스 변경 시 이벤트
	    itemChecks.forEach(check => {
	        check.addEventListener('change', function() {
	            const checkedCount = document.querySelectorAll('input[name="select_item"]:checked').length;
	            allCheck.checked = (checkedCount === itemChecks.length);
	        });
	    });
	    
	    // 5. 선택 삭제 버튼 클릭 시 (Fetch API)
	    deleteBtn.addEventListener('click', function() {
	        const checkedItems = document.querySelectorAll('input[name="select_item"]:checked');
	        
	        if (checkedItems.length === 0) {
	            alert("선택한 상품이 없습니다.");
	            return;
	        }

	        if (confirm("선택한 상품 " + checkedItems.length + "개를 장바구니에서 삭제하시겠습니까?")) {
	            // 선택된 상품 코드들을 배열로 수집
	            const codes = Array.from(checkedItems).map(cb => cb.value);

	            // 서버로 데이터 전송
	            fetch('${path}/product/delete_cart.do', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	                body: 'product_codes=' + codes.join(',')
	            })
	            .then(response => response.text())
	            .then(data => {
	                if (data === "success") {
	                    alert("삭제되었습니다.");
	                    location.reload(); // 페이지 새로고침하여 리스트 갱신
	                } else {
	                    alert("삭제에 실패했습니다.");
	                }
	            })
	            .catch(error => console.error('Error:', error));
	        }
	    });
	});
</script>
