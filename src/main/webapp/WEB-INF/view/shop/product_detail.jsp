<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section class="detail_section">
	<div align="center">
        <BR>
        <div class="product_detail">
        	<div id="main_img">
	        	<img id="product_detail_img" src="${product.product_img}">        
	        </div>
	        
			<div id="product_info" align="left">
				<c:import url="/WEB-INF/view/shop/product_detail_info1.jsp" />
				<hr>
				<c:import url="/WEB-INF/view/shop/product_detail_info2.jsp" />
				<hr>
				<c:import url="/WEB-INF/view/shop/product_detail_info3.jsp" >
					<c:param name="productCode" value="${product.product_code}" />
				</c:import>
			</div>
        </div>
		<BR> 
		<section class="review_section">
		    <div align="center">
		        <hr>
		        <h2>상품 후기</h2>
		        <c:import url="/WEB-INF/view/review/total_review.jsp">
				    <c:param name="totalAvg" value="${product.grade_point}" />
				    <c:param name="reviewCount" value="${reviewCount}" /> 
		        </c:import>
		        <c:import url="/review/review_list.do" />
		    </div>
		</section>
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />