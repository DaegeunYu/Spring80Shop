<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/view/include/top.jsp" />

<section class="list_section">
	<div align="center">
        <BR>
		<H1>
			<c:choose>
			    <c:when test="${param.is_single_origin eq 'y'}">
			    	싱글 오리진 리스트
	        	</c:when>
			    <c:otherwise>
			        블렌드 리스트
			    </c:otherwise>
			</c:choose>
		</H1>
		<div>
			<h5> 커피 가격은 1kg 기준 가격입니다. </h5>
		</div>
		<BR>
			<c:import url="/WEB-INF/view/shop/product_list_content.jsp" />
		<BR> 
	</div>
	<BR>
	<c:import url="/WEB-INF/view/shop/product_list_paging.jsp" />
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />
<script type="text/javascript">
    // 컨트롤러가 보낸 "msg"라는 이름의 FlashAttribute가 있는지 확인 (상품 등록 성공 확인용)
    var message = "${product_form_status}"; 
    
    if (message != null && message !== "") {
        alert(message); // 값이 있으면 팝업창을 띄운다!
    }
</script>