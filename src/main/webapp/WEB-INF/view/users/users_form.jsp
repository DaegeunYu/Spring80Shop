<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <br>
		<a href=${path}/index.do><img id=login_box_logo src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/logo.jpg"></a>
		
		<div class="join">
		<form action="${path}/users/users_formOK.do" method="post">
			<table id="member_join">
				<tr>
					<td><H2> 80's MEMBER JOIN </H2></td>
				</tr>
				
				<tr>
					<td>아이디</td><td><input type="text" id="user_id" name="user_id" ></td>
				</tr>
				<tr>
					<td>비밀번호</td><td><input type="text" id="user_pw" name="user_pw"></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td><td><input type="text" id="user_pw2" name="user_pw2"></td>
				</tr>
				<tr>
					<td>이름</td><td><input type="text" id="user_name" name="user_name"></td>
				</tr>
				<tr>
					<td>나이</td><td><input type="text" id="user_age" name="user_age"></td>
				</tr>
				<tr>
					<td>생일</td><td><input type="text" id="user_birthday" name="user_birthday"></td>
				</tr>
				<tr>
					<td>전화번호</td><td><input type="text" id="user_tel" name="user_tel"></td>
				</tr>
				<tr>
					<td>이메일</td><td><input type="text" id="user_email" name="user_email"></td>
				</tr>
				<tr>
					<td>주소</td><td><input type="text" id="user_add" name="user_add"></td>
				</tr>
				<tr>
					<td>성별</td><td><input type="text" id="user_gender" name="user_gender"></td>
				</tr>
				<tr>
					<td>추천자 아이디</td><td><input type="text" id="recommender_id" name="recommender_id"></td>
				</tr>
				<tr><td colspan=2><input type="submit" value="회원가입"></td></tr>
			</table>
		</form>
		</div>
		
		<BR> 
	</div>
	<BR>
</section>
<c:import url="/WEB-INF/view/include/bottom.jsp" />