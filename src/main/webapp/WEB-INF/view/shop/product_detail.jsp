<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section class="detail_section">
	<div align="center">
        <BR>
        <div class="product_detail">
        	<div id="main_img">
	        	<img id="product_detail_img" src="${product.product_img}">        
	        </div>
			<div id="product_info" align="left">
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
				<hr>
				
				<div class="product_detail">
					<div class="info_title">
						원산지
					</div>
					<div class="info_detail">
						${product.origin}
					</div>
				</div>
				<BR>
				
				<div class="product_detail">
					<div class="info_title">
						제조사
					</div>
					<div class="info_detail">
						${product.manufacturing}
					</div>
				</div>
				<BR>
				
				<div class="product_detail">
					<div class="info_title">
						배전도
					</div>
					<div class="info_detail">
						${product.roast_dgree}
					</div>
				</div>
				<BR>
				<hr>
				<BR>
			
				<div class="product_detail">
					<div class="info_title">
						분쇄 선택 *
					</div>
					<div class="info_detail">
						<select name="crushing" id="crushing">
						    <option value="not">분쇄안함</option>
						    <option value="handdrip">핸드드립</option>
						    <option value="aeropress">에어로프레스</option>
						    <option value="dutch">더치</option>
						    <option value="mokapot">모카포트</option>
						    <option value="espresso">에스프레소</option>
						 </select>						
					</div>
				</div>
				
				<div class="product_detail">
					<div class="info_title">
						무게 선택 *
					</div>
					<div class="info_detail">
						<select name="weight" id="weight">
						    <option value="m200">200g</option>
						    <option value="m350">350g</option>
						    <option value="m500">500g</option>
						    <option value="m1000">1Kg</option>
						 </select>						
					</div>
				</div>
				
			
			</div>
        </div>
		<BR> 
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />