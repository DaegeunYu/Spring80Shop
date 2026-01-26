<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<% String tp = request.getParameter("is_single_origin"); %>

<section>
	<div align="center">
        <br>
		<H2> <% if("y".equals(tp)){ %> 싱글 오리진 리스트 <% } else { %> 블렌드 리스트 <% } %> </H2>
		
		<div class="product_list">
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
							<strong class="product_price">${m.origin_price} 원</strong>
						</div>
					</div>			
				</c:forEach>
			</div>
		</div>
		
		<%-- <table border=1 width=800>
			<tr>
				<td>번호</td>
				<td>상품코드</td>
				<td>상품명</td>
				<td>싱글여부</td>
				<td>가격</td>
			</tr>
			<c:forEach var="m" items="${li}">
				<tr>
					<td>${m.idx}</td>
					<td>${m.product_code}</td>
					<td>${m.product_name}</td>
					<td>${m.is_single_origin}</td>
					<td>${m.origin_price}</td>
				</tr>
			</c:forEach>

		</table> --%>
		<BR> 
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />