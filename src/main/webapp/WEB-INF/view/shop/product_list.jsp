<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/view/include/top.jsp" />

<% String tp = request.getParameter("is_single_origin"); %>



<section>
	<div align="center">
        <br>
		<H2> <% if("y".equals(tp)){ %> 싱글 오리진 리스트 <% } else { %> 블렌드 리스트 <% } %> </H2>
		
		<div class="product">
			<c:forEach var="m" items="${li}">
				<div>
					<div>
						<a href="${path}/product/product_detail.do">
							<img class="product_img" src="${m.product_img}">
						</a>
					</div>
					<div class="product_name">
						<strong class="product_price">${m.product_name} </strong>
					</div>
					<div class="product_price">
						<strong class="product_price"><fmt:formatNumber value="${m.origin_price}" type="number"/>원</strong>
					</div>
				</div>			
			</c:forEach>
		</div>
		
		<BR> 
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />