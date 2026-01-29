<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>
	<br> 
	<div class="address_area" >
    <h3>배송지</h3>
    <p>수령인: ${users.user_name}</p>
    <p>연락처: ${users.user_tel}</p>
    <p>주소: ${users.user_add}</p>
</div>

</div>
