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
<style type="text/css">

</style>
</head>
<body>
<header>
<a href=${path}/index.do?page=1><img id=logo src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/logo.jpg"></a>
80's Coffee 
</header>
<nav>
&emsp;&emsp;&emsp;<a href=${path}/index.do&page=1>홈으로 </a>
&emsp;<a href=${path}/product/product_list.do?is_single_origin=y&page=1> 싱글 원두 </a>
&emsp;<a href=${path}/product/product_list.do?is_single_origin=n&page=1> 블렌딩 원두 </a>


&emsp;&emsp;&emsp;

<div class="user">

	<a href="${path}/users/users_form.do"> 회원가입 </a>&emsp;
	<!--  null 과 공배 모두 체크  -->
	<c:if test="${empty id}">
	  <a href="${path}/users/login.do"> 로그인</a> 
	</c:if>
	<c:if test="${not empty id}"> 
	  <a href="${path}/users/logout.do"> ${id}(로그아웃)</a>  
	</c:if>
</div>




</nav>