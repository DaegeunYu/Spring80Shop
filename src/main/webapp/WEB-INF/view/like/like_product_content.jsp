<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		
<div class="product">
	<c:forEach var="m" items="${product_list}">
		<div>
			<div>
				<a href="${path}/product/product_detail.do?product_code=${m.product_code}">
					<img class="product_img" src="${m.product_img}">
				</a>
			</div>
			<div class="product_name">
				<strong>${m.product_name} </strong>
			</div>
		</div>			
	</c:forEach>
</div>