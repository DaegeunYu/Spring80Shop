<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>
	<H2> ${product.product_name} </H2>
</div>
<div>
	<c:choose>
		<c:when test="${product.origin_price == product.sale_price}">
               <strong class="sale_price_detail">
                   <fmt:formatNumber value="${product.origin_price}" type="number"/>원
               </strong>
           </c:when>
           <c:otherwise>
           	<strong class="discount_rate_detail">
                   <fmt:formatNumber value="${(product.origin_price - product.sale_price) / product.origin_price}" type="percent" maxFractionDigits="0"/>
               </strong>
           	<strong class="sale_price_detail">
                   <fmt:formatNumber value="${product.sale_price}" type="number"/>원
               </strong>
               <strong class="origin_price_detail">
                   <fmt:formatNumber value="${product.origin_price}" type="number"/>원
               </strong>
           </c:otherwise>
	</c:choose>
</div>