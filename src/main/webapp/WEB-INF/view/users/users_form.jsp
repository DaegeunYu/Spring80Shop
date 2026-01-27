<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />

<section>
	<div align="center">
        <br>
		<a href=${path}/index.do><img id=login_box_logo src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/logo.jpg"></a>
		
		<div class="join">
		<form action="${path}/users/users_formOK.do" method="post" onSubmit="return formOK()">
			<table id="member_join">
				<tr>
					<td><H2> 80's MEMBER JOIN </H2></td>
				</tr>
				
				<tr>
					<td>아이디</td><td><input type="text" id="user_id" name="user_id"  required>
					<br><button id="idCheck">아이디 중복 확인</button></td>
				</tr>
				<tr>
					<td>비밀번호</td><td><input type="text" id="user_pw" name="user_pw" required></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td><td><input type="text" id="user_pw2" name="user_pw2" required></td>
				</tr>
				<tr>
					<td>이름</td><td><input type="text" id="user_name" name="user_name" required></td>
				</tr>
				<tr>
					<td>생일</td><td><input type="text" id="user_birthday" name="user_birthday" 
              						 placeholder="예: 20260101" maxlength="8" required>
       								 <small style="color: gray;"><br>(8자리 숫자로 입력해 주세요)</small>
       								 </td>
				</tr>
				<tr>
					<td>전화번호</td><td><input type="text" id="user_tel" name="user_tel" required></td>
				</tr>
				<tr>
					<td>이메일</td><td><input type="text" id="user_email" name="user_email" required></td>
				</tr>
				<tr>
					<td>주소</td><td><input type="text" id="user_add" name="user_add" required></td>
				</tr>
				<tr>
					<td>성별</td>
					<td><select name="user_gender">
  							<option value="M">남</option>
  							<option value="W">여</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>추천자 아이디</td><td><input type="text" id="recommender_id" name="recommender_id"></td>
				</tr>
				<tr><td colspan="2" align="center"><input type="submit" value="회원가입" ></td></tr>
			</table>
		</form>
		</div>
		
		<BR> 
	</div>
	<BR>
</section>


<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script>
function formOK() {
    // 1. 입력 필드에서 값을 가져옵니다.
    var birth = document.getElementById("user_birthday").value;
    
    // 2. 정확한 날짜 형식인지 검사하는 정규식
    const regBirth = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;

    // 3. 검증 수행
    if(!regBirth.test(birth)) {
        alert('정확한 생년월일 8자리를 입력해주세요\n(예: 19990101)');
        document.getElementById("user_birthday").focus();
        
        // return false가 있어야 서버로 넘어가지 않음
        return false; 											// 미래날짜 선택불가, 미성년 가입불가 추가 예정
        
    }
    return true;
}


$('#idCheck').click(function(e) {
	
	e.preventDefault(); // 버튼 클릭 시 폼이 Submit되는 것 방지
	
	//alert("아이디 중복체크");
	
	var user_id = $('#user_id').val().trim(); // 변수선언, trim() 앞 뒤 불필요한 공백 제거
	
	  if (user_id === "") {
	        alert("아이디를 입력해주세요.");
	        $('#user_id').focus();
	        return; // AJAX 호출 중단
	    }
	
	var path = '${path}';
	
	$.ajax({
		type : "GET",
		url : path + "/users/idCheck.do",
		data : { user_id : user_id },  // 변수 전달
		success : function(data) {
			if(data == 'T'){
			   alert("중복된 이름이 있습니다.");
			   $('#user_id').val("")
			} else {
			   alert("사용 가능한 이름 입니다.");
			}
			// location.reload();
		},
		error : function(xhr, status, error) {
			// 에러 처리 추가 권장
			alert("저장 실패: " + status + " (" + error + ")");
		}
	})
});



</script>


<c:import url="/WEB-INF/view/include/bottom.jsp" />