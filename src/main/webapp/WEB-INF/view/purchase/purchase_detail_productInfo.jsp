<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="product_info_area">
    <h3>주문 상품 정보</h3>
    <table border="1" class="order_table"> 
        <colgroup>
            <col width="10%">
            <col width="40%">
            <col width="10%">
            <col width="10%">
            <col width="30%">
        </colgroup>
            <tr>
                <td>
                    <img id="purchase_detail_img" src="${product.product_img}" > 
                </td>
                <td><strong>${product.product_name}</strong></td>
                
                <td><fmt:formatNumber value="${product.sale_price}" type="number"/>원</td>
                
                <td>${product_count}개</td>
                <td>
                    <fmt:formatNumber value="${product.sale_price * product_count}" type="number"/>원
                </td>
            </tr>
       
    </table>
</div>