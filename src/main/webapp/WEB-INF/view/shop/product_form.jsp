<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>80s coffee 상품등록</title>
</head>
<body>
<header class="form-page-header">
    <h1>상품 등록</h1>
    <p>새로운 원두 상품 정보를 입력해주세요.</p>
</header>
<form action="${path}/product/productOK.do" method="post" enctype="multipart/form-data">
	<table id="product-form-table">
		<tr>
			<td class="pft_title">원두의 종류</td>
			<td>
				<div class="origin-type-container">
				    <input type="radio" name="is_single_origin" value="Y" id="origin_Y" checked>
				    <label for="origin_Y" class="type-label left">싱글 원두</label>
				
				    <input type="radio" name="is_single_origin" value="N" id="origin_N">
				    <label for="origin_N" class="type-label right">블렌딩 원두</label>
				</div>
			</td>
		</tr>
		<tr>
			<td class="pft_title">디카페인 여부</td>
			<td>
				<div class="caffeine-type-container">
				    <input type="radio" name="is_decafe" value="N" id="caffeine_N" checked>
				    <label for="caffeine_N" class="type-label left">카페인</label>
				
				    <input type="radio" name="is_decafe" value="Y" id="caffeine_Y">
				    <label for="caffeine_Y" class="type-label right">디카페인</label>
				</div>
			</td>
		</tr>
		<tr>
			<td class="pft_title">상품코드</td>
			<td class="pft_text_box_s"><input type="text" name="product_code"></td>
		</tr>
		<tr>
			<td class="pft_title">상품명</td>
			<td class="pft_text_box_l"><input type="text" name="product_name"></td>
		</tr>
		<tr>
			<td class="pft_title">대표이미지</td>
			<td><input type="file" name="product_img"></td>
		</tr>
		<tr>
			<td class="pft_title">원산지</td>
			<td class="pft_text_box_m"><input type="text" name="origin"></td>
		</tr>
		<tr>
			<td class="pft_title">브랜드</td>
			<td class="pft_text_box_m"><input type="text" name="brand"></td>
		</tr>
		<tr>
			<td class="pft_title">볶음도</td>
			<td class="pft_text_box_m"><input type="text" name="roast_dgree"></td>
		</tr>
		
		<tr>
			<td class="pft_title">제조사</td>
			<td class="pft_text_box_m"><input type="text" name="manufacturing"></td>
		</tr>
		<tr>
			<td class="pft_title">판매가</td>
			<td class="pft_text_box_m"><input type="text" name="origin_price"></td>
		</tr>
		<tr>
			<td class="pft_title">할인가</td>
			<td class="pft_text_box_m"><input type="text" name="sale_price"></td>
		</tr>
		
	    <tr>
	    	<td class="pft_title">상품 옵션 설정</td>
	        <td>
	        <button type="button" onclick="addOption()">+ 옵션 추가</button>
				<div id="option_container">
					<div class="option-item" style="margin-bottom: 5px;">
						<select name="optionList[0].product_weight">
							<option value="200g">200g</option>
							<option value="350g">350g</option>
							<option value="500g">500g</option>
							<option value="1kg">1kg</option>
						</select>
						<input type="text" name="optionList[0].product_price" placeholder="옵션 가격">
					</div>
				</div>
			</td>
        </tr>

		<tr>
			<td class="pft_title">재고</td>
			<td class="pft_text_box_s"><input type="text" name="quantity"></td>
		</tr>
		<tr>
			<td class="pft_title">상품 출시일</td>
			<td class="pft_text_box_s"><input type="text" name="release_date"></td>
		</tr>
		<tr>
			<td class="pft_title">유통기한</td>
			<td class="pft_text_box_s"><input type="text" name="expiration_date"></td>
		</tr>

	
	</table>
	<div class="form-submit-container">
        <input type="submit" value="저장하기" class="btn-save">
    </div>
</form>

</body>
<c:import url="/WEB-INF/view/include/bottom.jsp" />
<script>
    let optionIdx = 1; // 추가될 옵션의 인덱스
    function addOption() {
        const container = document.getElementById('option_container');
        const div = document.createElement('div');
        div.className = 'option-item';
        div.innerHTML = `
            <select name="optionList[${optionIdx}].product_weight">
	        	<option value="200g">200g</option>
				<option value="350g">350g</option>
				<option value="500g">500g</option>
				<option value="1kg">1kg</option>
			</select>
            <input type="text" name="optionList[${optionIdx}].product_price" placeholder="옵션 가격">
            <button type="button" onclick="this.parentElement.remove()">삭제</button>
        `;
        container.appendChild(div);
        optionIdx++; // 다음 추가를 위해 인덱스 증가
    }
</script>
</html>