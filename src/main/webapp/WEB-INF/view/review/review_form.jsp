<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/review.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section class="review-write-container">
    <h2>리뷰 작성</h2>
    
    <div class="product-info-header">
        <img src="${pageContext.request.contextPath}/resources/files/${product.product_img}" alt="상품이미지">
        <div class="info-text">
            <p class="brand">${product.brand}</p>
            <p class="name">${product.product_name}</p>
            <p class="option">선택: ${product.product_weight} / ${product.crushing}</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/review/insertReview.do" method="post" id="reviewForm" enctype="multipart/form-data">
        <input type="hidden" name="idx" value="${orderInfo.idx}">
        <input type="hidden" name="productCode" value="${orderInfo.productCode}">
        <input type="hidden" name="orderCode" value="${orderInfo.orderCode}">

        <div class="rating-section">
            
            <div class="rv-write__star-wrap">
                <input type="radio" id="star5" name="gradePoint" value="5" /><label for="star5" title="5점">★</label>
                <input type="radio" id="star4" name="gradePoint" value="4" /><label for="star4" title="4점">★</label>
                <input type="radio" id="star3" name="gradePoint" value="3" /><label for="star3" title="3점">★</label>
                <input type="radio" id="star2" name="gradePoint" value="2" /><label for="star2" title="2점">★</label>
                <input type="radio" id="star1" name="gradePoint" value="1" /><label for="star1" title="1점">★</label>
            </div>
            <div id="star-message">별점을 선택해주세요.</div>
        </div>
		<p>상품은 어떠셨나요?</p>
        <div class="title-section">
		    <input type="text" name="reviewTitle" placeholder="한 줄 평을 남겨주세요." style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 10px;">
		</div>
		
		<p>상세 후기</p>
		<div class="content-section">
		    <textarea name="reviewContent" placeholder="다른 구매자에게 도움이 되도록 상세한 리뷰를 작성해주세요. (최소 10자)"></textarea>
		</div>

        <div class="file-section">
            <label for="file-input" class="file-label">
                <span class="icon">📷</span> 사진 첨부하기
            </label>
            <input type="file" id="file-input" name="review_file" accept="image/*" style="display:none;">
            <div id="image-preview"></div>
        </div>

        <button type="submit" class="submit-btn">등록하기</button>
    </form>
</section>

<c:import url="/WEB-INF/view/include/bottom.jsp" />

<script>

	//기존 스크립트 하단에 추가
	document.querySelector('form').addEventListener('submit', function(e) {
	    const grade = document.querySelector('input[name="gradePoint"]:checked');
	    const title = document.querySelector('input[name="reviewTitle"]').value.trim();
	    const content = document.querySelector('textarea[name="reviewContent"]').value.trim();
	
	    if (!grade) {
	        alert("별점을 선택해주세요!");
	        e.preventDefault(); // 전송 중단
	        return;
	    }
	    if (title === "") {
	        alert("제목(한 줄 평)을 입력해주세요!");
	        e.preventDefault();
	        return;
	    }
	    if (content.length < 10) {
	        alert("상세 후기를 10자 이상 작성해주세요!");
	        e.preventDefault();
	        return;
	    }
	    if (!confirm("리뷰를 등록하시겠습니까?")) {
	        e.preventDefault(); // '취소' 클릭 시 전송 중단
	    }
	});
    // 이미지 미리보기 로직
    document.getElementById('file-input').addEventListener('change', function(e) {
        const preview = document.getElementById('image-preview');
        preview.innerHTML = ''; 
        
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                const img = document.createElement('img');
                img.src = event.target.result;
                preview.appendChild(img);
            };
            reader.readAsDataURL(file);
        }
    });

    // 별점 메시지 변경 로직
    const radioButtons = document.querySelectorAll('input[name="gradePoint"]');
    const starMsg = document.getElementById('star-message');
    const messages = {
        '5': '최고예요! 아주 만족합니다.',
        '4': '좋아요! 만족스러워요.',
        '3': '보통이에요. 무난합니다.',
        '2': '그냥 그래요. 아쉬워요.',
        '1': '별로예요. 실망했습니다.'
    };

    radioButtons.forEach(radio => {
        radio.addEventListener('change', (e) => {
            starMsg.innerText = messages[e.target.value];
            starMsg.style.color = '#ffcc00';
            starMsg.style.fontWeight = 'bold';
        });
    });
</script>