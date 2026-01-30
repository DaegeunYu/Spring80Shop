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
			<table id="users_join">
				<tr>
					<td><H2> 80's MEMBER JOIN </H2></td>
				</tr>
				
				<tr>
					<td><input type="text" id="user_id" name="user_id" placeholder="아이디" required>
					<button id="idCheck">아이디 중복 확인</button></td>
				</tr>
				<tr>
					<td><input type="password" id="user_pw" name="user_pw" placeholder="비밀번호" required></td>
				</tr>
				<tr>
					<td><input type="password" id="user_pw2" name="user_pw2" placeholder="비밀번호 확인" required></td>
				</tr>
				<tr>
					<td><input type="text" id="user_name" name="user_name" placeholder="이름" required></td>
				</tr>
				<tr>
					<td><input type="text" id="user_birthday" name="user_birthday" 
              			placeholder="예: 20260101" maxlength="8" placeholder="생년월일" required value="19991111"> <!-- PJ TODO : 테스트 완료 후 value 삭제 -->
       					<small style="color: gray;"><br>(8자리 숫자로 입력해 주세요)</small>
       				</td>
				</tr>
				<tr>
					<td><input type="text" id="user_tel" name="user_tel" placeholder="전화번호" required></td>
				</tr>
				<tr>
					<td><input type="text" id="user_email" name="user_email" placeholder="이메일" required></td>
				</tr>
				<tr>
					<td><input type="text" id="user_add" name="user_add" placeholder="주소" required> <!-- PJ TODO : 테스트 완료 후 type="hidden"으로 교체 placeholder="주소" 삭제-->
						<input type="text" id="sample6_postcode" placeholder="우편번호">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample6_address" placeholder="주소"><br>
						<input type="text" id="sample6_detailAddress" placeholder="상세주소">
						<input type="text" id="sample6_extraAddress" placeholder="참고항목">
					
					</td>
				</tr>
				<tr>
					<td class="gender_row">
       					 <label>성별</label>
       					 <select name="user_gender">
        				    <option value="M">남</option>
           					<option value="W">여</option>
        </select>
    </td>
				</tr>
				<tr>
					<td><input type="text" id="recommender_id" name="recommender_id" placeholder="추천자 아이디"></td>
				</tr>
				<tr><td colspan="2" align="center"><input type="submit" value="회원가입" ></td></tr>
			</table>
		</form>
		</div>
		
		<BR> 
	</div>
	<BR>
</section>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script>

/* PJ TODO : 테스트 완료 후 주석 삭제 

var idCheck = false; // 아이디 중복 확인 여부 확인 전역변수

// 카카오 주소 API
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
	
// 아이디 중복체크
$('#idCheck').click(function(e) {
	
	e.preventDefault(); // 버튼 클릭 시 폼이 Submit되는 것 방지
	
	var user_id = $('#user_id').val().trim(); // 변수선언, trim() 앞 뒤 불필요한 공백 제거
	
	  if (user_id === "") {
	        alert("아이디를 입력해주세요.");
	        $('#user_id').focus();
	        return; // AJAX 호출 중단
	  }
	
	// 아이디 정규식 검사 (소문자+숫자 조합, 6~16자)
	var userId = document.getElementById("user_id").value;
	var regId = /^(?=.*[a-z])(?=.*\d)[a-z\d]{6,16}$/;

	if (!regId.test(userId)) {
		   alert("아이디는 영문 소문자와 숫자를 조합하여 6~16자로 입력해주세요.");
		   document.getElementById("user_id").focus();
		   return false;
	}
	
	var path = '${path}';
	
	$.ajax({                                   
		type : "GET",
		url : path + "/users/idCheck.do",
		data : { user_id : user_id },  // 변수 전달
		success : function(data) {
			if(data == 'T'){
			   alert("중복된 아이디가 있습니다.");
			   $('#user_id').val("")
			} else {
			   alert("사용 가능한 아이디 입니다.");
			   idCheck = true;
			}
			// location.reload();
		},
		error : function(xhr, status, error) {
			// 에러 처리 추가 권장
			alert("저장 실패: " + status + " (" + error + ")");
		}
	})
});
	
		
function formOK() {
	
	// 아이디 중복 확인 여부 체크
	if(!idCheck) {
        alert("아이디 중복 확인을 먼저 완료해주세요.");
        return false;
    }
    
	// 비밀번호 일치 확인
    var pw = document.getElementById("user_pw").value;
    var pw2 = document.getElementById("user_pw2").value;
    
 	// 비밀번호 정규식 영문 소문자, 숫자, 특수문자가 각각 최소 1개 이상 포함된 8~16자
    const regPw = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[a-z\d@$!%*?&]{8,16}$/;
    if (!regPw.test(pw)) {
        alert("비밀번호는 영문 소문자, 숫자, 특수문자(@$!%*?&)를 조합하여 8~16자로 입력해주세요.");
        document.getElementById("user_pw").focus();
        return false;
    }
    
    if(pw !== pw2){
    	alert("비밀번호가 일치하지 않습니다.");
        document.getElementById("user_pw2").focus();
        return false; // 폼 제출 막기
    }
    
	// 이름 정규식 검사
    var name = document.getElementById("user_name").value;
    var regName = /^[가-힣]{2,5}$/;
    
    if (!regName.test(name)) {
        alert("이름은 한글 2~5자 이내로 입력해주세요.");
        document.getElementById("user_name").focus();
        return false;
    }
    
    // 생일 입력 정규식 검사
    var birth = document.getElementById("user_birthday").value;
    const regBirth = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;

    if(!regBirth.test(birth)) {                               
        alert('정확한 생년월일 8자리를 입력해주세요\n(예: 19990101)');
        document.getElementById("user_birthday").focus();
        return false; 											
        
    }
    
    var year = Number(birth.substring(0, 4));
    var month = Number(birth.substring(4, 6)) - 1; 
    var day = Number(birth.substring(6, 8));

    var birthDate = new Date(year, month, day);

    // 핵심: 생성된 날짜 객체의 연/월/일이 입력값과 일치하는지 비교
    if (birthDate.getFullYear() !== year || 
        birthDate.getMonth() !== month || 
        birthDate.getDate() !== day) {
        
        alert("존재하지 않는 날짜입니다. (예: 2월 30일 등)");
        document.getElementById("user_birthday").focus();
        return false;
    }

    var today = new Date(); 

    // 미래 날짜 차단
    if (birthDate > today) {
        alert("미래 날짜는 입력할 수 없습니다.");
        document.getElementById("user_birthday").focus();
        return false;
    }

    // 미성년자 가입 제한 (만 19세 기준)
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();

    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }

    if (age < 19) {
        alert("만 19세 미만의 미성년자는 가입할 수 없습니다.");
        document.getElementById("user_birthday").focus();
        return false;
    }
    
 	// 전화번호 정규식 검사
	var telInput = document.getElementById("user_tel").value;
	var cleanTel = telInput.replace(/-/g, ''); // 하이픈 제거 
	var regTel = /^(01[016789]|02|0[3-9][0-9])\d{3,4}\d{4}$/; // 010, 지역번호, 070등 포함

	if (!regTel.test(cleanTel)) {
	    alert("올바른 전화번호 형식이 아닙니다. 확인 후 입력해주세요.");
	    return false;
	}
    
	// 이메일 정규식 검사
	var f = document.forms[0];
	var userEmail = f.user_email.value;
	var regEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if (!regEmail.test(userEmail)) {
        alert("이메일 형식이 올바르지 않습니다.");
        f.user_email.focus(); 
        return false;
    }
	
 	// 추천자 아이디 검사 (선택 사항)
    var recommender_id = document.getElementById("recommender_id").value.trim();
    if (recommender_id !== "") { // 입력값이 있을 때만 검사 진행
        var regId = /^(?=.*[a-z])(?=.*\d)[a-z\d]{6,16}$/;
        if (!regId.test(recommender_id)) {
            alert("추천자 아이디 형식이 올바르지 않습니다.\n(영문 소문자/숫자 조합 6~16자)");
            document.getElementById("recommender_id").focus();
            return false;
        }
    }
    
    // 주소입력
    var postcode = document.getElementById("sample6_postcode").value.trim();
    if(postcode === "") {
        alert("주소 검색을 완료해 주세요.");
        return false; 
    }

    var detail = document.getElementById("sample6_detailAddress").value.trim();
    if(detail === "") {
        alert("상세 주소를 입력해 주세요.");
        document.getElementById("sample6_detailAddress").focus();
        return false; 
    }
    // 주소 합치기
    var postcode = document.getElementById("sample6_postcode").value.trim();
    var addr = document.getElementById("sample6_address").value.trim();
    var detail = document.getElementById("sample6_detailAddress").value.trim();
    var extra = document.getElementById("sample6_extraAddress").value.trim();

    var fullAddress = "[" + postcode + "] " + addr + " " + detail;
    if(extra !== "") {
        fullAddress += " " + extra;
    }

    document.getElementById("user_add").value = fullAddress;
    
    return true;
}

===========================테스트 완료 후 주석 삭제 */

</script>


<c:import url="/WEB-INF/view/include/bottom.jsp" />