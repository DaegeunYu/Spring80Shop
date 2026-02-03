<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="recently">
	<div>
		<h3>최근 본 상품 목록</h3>
	</div>
	
	<div class="scroll-container">
		<ul class="scroll-list">
			<c:forEach var="m" items="${recent_product_list}">
				<li>
					<p>${m.product_name} </p>
					<a href="${path}/product/product_detail.do?product_code=${m.product_code}">
						<img class="recent_product_img" src="${m.product_img}">
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>


<script type="text/javascript">
	window.onload = function() {
		const recently = document.querySelector('.recently');
		const container = document.querySelector('.scroll-container');
	    const list = document.querySelector('.scroll-list');
	    
		// 1. 항목이 하나도 없는지 확인 (li 태그의 개수)
	    const items = list.querySelectorAll('li');
	    
	    if (items.length === 0) {
	        // 항목이 없으면 컨테이너를 아예 숨김
	        recently.style.display = 'none';
	        return; // 이후 로직 실행 방지
	    }

	    // 2. 너비 계산
	    const containerWidth = container.offsetWidth;
	    const listWidth = list.scrollWidth;

	    // 3. 리스트가 컨테이너보다 길 때만 복제 및 애니메이션 적용
	    if (listWidth > containerWidth) {
	        const clone = list.innerHTML;
	        list.innerHTML += clone;
	        list.classList.add('is-rolling');
	    } else {
	        // 리스트가 짧을 때 처리 (중앙 정렬 등)
	        list.style.justifyContent = 'center';
	        list.style.width = '100%';
	    }
	};
</script>