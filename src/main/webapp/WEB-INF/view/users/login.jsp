<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <br>
		<a href=${path}/index.do?page=1><img id=login_box_logo src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/logo.jpg"></a>
		<br><br>
		<div class="login">
		<form action="${path}/users/loginSuccess.do" method="post">
			<table id="login_box">
				<tr>
					<td><H2> 80's MEMBER LOGIN </H2></td>
				</tr>
				<tr>
				<td>
				<div class="login-type-container">
				    <input type="radio" name="userType" value="member" id="member" checked>
				    <label for="member" class="type-label left">일반회원</label>
				
				    <input type="radio" name="userType" value="business" id="business">
				    <label for="business" class="type-label right">법인회원</label>
				</div>
				<br>
					<input type="text" id="user_id" name="user_id" placeholder="아이디"></td>
				</tr>
				<tr>
					<td><input type="password" id="user_pw" name="user_pw" placeholder="비밀번호"></td>
				</tr>
				<tr>
					<td><input type="submit"  value="로그인"><input type="button" OnClick="signForm()" value="회원가입"></td>
				</tr>
			</table>
		</form>
		</div>
		
		<BR> 
	</div>
	<BR>
</section>
<script type="text/javascript">
	var message = "${msg}";
	if (message !== "") {
		alert(message);
	}
	function signForm() {
		location.href="${path}/users/users_form.do";
	}
</script>
<c:import url="/WEB-INF/view/include/bottom.jsp" />