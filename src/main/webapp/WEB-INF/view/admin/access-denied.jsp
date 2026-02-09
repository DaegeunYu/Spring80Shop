<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div class="error-container">
	    <h1 class="error-code">403</h1>
	    <div class="error-message">
	        <strong>접근 권한이 없습니다.</strong><br>
	        이 페이지를 볼 수 있는 권한이 없거나 로그인이 필요합니다.
	    </div>
	    
	    <div class="btn-group">
	        <a href="javascript:history.back();" class="btn btn-back">이전 페이지</a>
	    </div>
	</div>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />