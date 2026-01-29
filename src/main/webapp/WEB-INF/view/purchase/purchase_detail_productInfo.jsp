<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="product_info_area">
    <h3>주문 상품 정보</h3>
    <table border="1" > <!-- PJ TODO : css 스타일에서 테이블 이미지 사이즈 조정 -->
        <colgroup>
            <col width="20%">
            <col width="40%">
            <col width="20%">
            <col width="20%">
        </colgroup>
            <tr>
                <td>
                    <img id="product_detail_img" src="${product.product_img}" > <!-- PJ TODO : css 스타일에서 사이즈 조정 -->
                </td>
                <td><strong>${product.product_name}</strong></td>
                <td>
                    <fmt:formatNumber value="${product.sale_price}" type="number"/>원
                </td>
                <td>${product_count}개</td>
            </tr>
       
    </table>
</div>