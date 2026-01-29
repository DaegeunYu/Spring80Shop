<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />

<section class="list_section">
	<div align="center">
        <BR>
		<h1> 80's Coffee를 소개합니다! </h1>
		<c:import url="/WEB-INF/view/shop/product_list_content.jsp" />
		<BR> 
	</div>
	<BR>
	<c:import url="/WEB-INF/view/shop/product_list_paging.jsp" />
	<BR>
</section>

<script>
    // 회원가입 완료 환영 메시지
    var msg = "${msg}";
    if(msg !== "") {
        alert(msg);
    }
</script>

<c:import url="/WEB-INF/view/include/bottom.jsp" />