<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
 
<c:set var="path" scope="request" 
   value="${pageContext.request.contextPath}" /> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>80's Roasters Coffee</title>
<link href="${path}/resources/css/top.css" rel="stylesheet">
<link href="${path}/resources/css/login.css" rel="stylesheet">
<link href="${path}/resources/css/product.css" rel="stylesheet">
<link href="${path}/resources/css/user_form.css" rel="stylesheet">
<link href="${path}/resources/css/purchase.css" rel="stylesheet">
<link href="${path}/resources/css/sign.css" rel="stylesheet">
</head>
<body>
<header class="top-logo-img">
<a href=${path}/index.do?page=1><img id=logo src="${pageContext.request.contextPath}/resources/files/common/logo.jpg"></a>
80's Coffee 
</header>
<nav>
	<div class="nav-content">
		<div class="nav-links">
			<a href=${path}/index.do?page=1>홈으로 </a>
			<a href=${path}/product/product_list.do?is_single_origin=y&page=1> 싱글 원두 </a>
			<a href=${path}/product/product_list.do?is_single_origin=n&page=1> 블렌딩 원두 </a>
		</div>
		
		<div class="user">
			<!--  비회원  -->
			<c:choose>			
				<c:when test="${empty id}">
					<a href="${path}/users/sign_up.do"> 회원가입 </a>
					<a href="${path}/users/login.do"> 로그인</a> 
				</c:when>			
				
				<c:otherwise>
					<!--  관리자  -->
					<c:if test="${userRole eq 'admin'}">
						<a href="${path}/admin/manager.do"> 관리자 페이지 </a>
					</c:if>
					
					<!--  법인 회원  -->
					<c:if test="${userRole eq 'business'}">
					</c:if>
					<div class="mypage-container">
						<!--  회원  -->
						<div class="mypage-trigger"><a> 마이페이지 </a></div>
						<ul class="submenu">
							<!--  공통 메뉴  -->
							<li><a href="${path}/basket/basket_list.do">장바구니</a></li>
							<li><a href="${path}/purchase/purchaseList.do">구매 내역</a></li>
							<li><a href="${path}/product/like_product.do?page=1">찜 리스트</a></li>
						</ul>
					</div>
					<a href="${path}/users/logout.do"> ${id}(로그아웃)</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</nav>