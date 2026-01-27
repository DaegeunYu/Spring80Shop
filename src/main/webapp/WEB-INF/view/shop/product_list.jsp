<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/view/include/top.jsp" />

<% String tp = request.getParameter("is_single_origin"); %>

<section class="list_section">
	<div align="center">
        <BR>
		<H2> <% if("y".equals(tp)){ %> 싱글 오리진 리스트 <% } else { %> 블렌드 리스트 <% } %> </H2>
		
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
					<div class="product_price">
						<c:choose>
							<c:when test="${m.origin_price == m.sale_price}">
				                <strong class="sale_price">
				                    <fmt:formatNumber value="${m.origin_price}" type="number"/>원
				                </strong>
				            </c:when>
				            <c:otherwise>
				            	<strong class="discount_rate">
				                    <fmt:formatNumber value="${(m.origin_price - m.sale_price) / m.origin_price}" type="percent" maxFractionDigits="0"/>
				                </strong>
				            	<strong class="sale_price">
				                    <fmt:formatNumber value="${m.sale_price}" type="number"/>원
				                </strong>
				                <strong class="origin_price">
				                    <fmt:formatNumber value="${m.origin_price}" type="number"/>원
				                </strong>
				            </c:otherwise>
						</c:choose>
					</div>
				</div>			
			</c:forEach>
		</div>

		<BR> 
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />