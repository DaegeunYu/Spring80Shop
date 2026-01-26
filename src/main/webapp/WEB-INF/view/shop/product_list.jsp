<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
<% String title = request.getParameter("is_single_origin"); %>
	<div align="center">
        <br>
		<H2> <% if(title=="y"){ %> 싱글 오리진 리스트 <% } else { %> 블렌드 리스트 <% } %> </H2>
		
		<table border=1 width=800>
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

		</table>
		<BR> 
		
		<br>
	</div>
	<br>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />