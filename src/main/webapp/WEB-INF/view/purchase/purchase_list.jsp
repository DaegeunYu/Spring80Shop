<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <BR>
		<H2> 구매 내역 </H2>
		<BR>
		<table>
			<tr>
				<td></td> <!-- 1. order_code -->
				<td></td> <!-- 2. user_id -->
				<td></td> <!-- 3. product_code -->
				<td></td> <!-- 4. product_name -->
				<td></td> <!-- 5. product_weight -->
				<td></td> <!-- 6. crushing -->
				
				<td></td> <!-- 7. order_count -->
				<td></td> <!-- 8. order_price -->
				<td></td> <!-- 9. order_date -->
				<td></td> <!-- 10. order_status -->
				
				<td></td> <!-- 11. is_review -->
			</tr>
			<c:forEach var="li" items="${purchaselist}">
				<tr>
					<td>${li.order_code}</td>
					<td>${li.user_id}</td>
					<td>${li.product_code}</td>
					<td>${li.product_name}</td>
					<td>${li.product_weight}</td>
					<td>${li.crushing}</td>
					<td>${li.order_count}</td>
					<td>${li.order_price}</td>
					<td>${li.order_date}</td>
					<td>${li.order_status}</td>
					<td>${li.is_review}</td>
				</tr>
			</c:forEach>
		</table>
			
			  
  
  
  
  
  
  
  
  
 

  
		<BR>
		<div> ${product.product_name} </div>		
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />