<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <br>
		<a href=${path}/index.do?page=1><img id=login_box_logo src="${pageContext.request.contextPath}/resources/files/common/logo.jpg"></a>
		<br><br>
		<div class="login">
		<form action="${pageContext.request.contextPath}/users/loginOK.do" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<table id="login_box">
				<tr>
					<td><H2> 80's MEMBER LOGIN </H2></td>
				</tr>
				<tr>
				<td>
				<div class="login-type-container">
				    <input type="radio" name="user_type" value="personal" id="personal" checked>
				    <label for="personal" class="type-label left">일반회원</label>
				
				    <input type="radio" name="user_type" value="business" id="business">
				    <label for="business" class="type-label right">기업회원</label>
				</div>
				<br>
					<input type="text" id="user_id" name="user_id" placeholder="아이디"></td>
				</tr>
				<tr>
					<td><input type="password" id="user_pw" name="user_pw" placeholder="비밀번호"></td>
				</tr>
				<tr>
					<td>
						<input type="submit"  value="로그인"><input type="button" OnClick="signForm()" value="회원가입">
					</td>
				</tr>
			</table>
		</form>
		</div>
		
		<BR> 
	</div>
	<BR>
</section>
<script type="text/javascript">
	<c:if test="${not empty sessionScope.msg}">
		// c:out은 XSS 공격을 방지하고 문자열을 안전하게 출력해줍니다.
	    var msg = "<c:out value='${sessionScope.msg}' />";	    
	    // c:out이 특수문자를 변환해버릴 수 있으므로 다시 되돌려서 alert에 뿌립니다.
	    alert(msg.replace(/&amp;#010;/g, '\n').replace(/&amp;#10;/g, '\n').replace(/\\n/g, '\n'));
	    // 팝업 띄운 후 바로 세션에서 제거 (잔상 방지)
	    <% session.removeAttribute("msg"); %>
	</c:if>

	function signForm() {
		location.href="${path}/users/users_form.do";
	}
</script>
<c:import url="/WEB-INF/view/include/bottom.jsp" />