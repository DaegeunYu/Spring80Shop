<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>회원가입 구분</title>
</head>
<section id="sign_select">
<div id="sign_select_header">
	<h1>회 원 가 입</h1>
	<h3>가입하시려는 유형을 선택해주세요</h3>
</div>
<div class="selection-container">
    <a href="${path}/users/users_form.do" class="sign-card">🧍 일반 회원  </a>
    <a href="${path}/users/business_users_form.do" class="sign-card">🏢 기업 회원  </a>
</div>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />
</html>