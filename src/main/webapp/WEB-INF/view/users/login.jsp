<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <br>
		<a href=${path}/index.do><img id=login_box_logo src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/logo.jpg"></a>
		
		<div class="login">
		<form action="${path}/users/loginSuccess.do" method="post">
			<table id="login_box">
				<tr>
					<td><H2> 80's MEMBER LOGIN </H2></td>
				</tr>
				<tr>
					<td><input type="text" id="user_id" name="user_id"></td>
				</tr>
				<tr>
					<td><input type="text" id="user_pw" name="user_pw"></td>
				</tr>
				<tr>
					<td><input type="submit"  value="로그인"></td>
				</tr>
			</table>
		</form>
		</div>
		
		<BR> 
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />