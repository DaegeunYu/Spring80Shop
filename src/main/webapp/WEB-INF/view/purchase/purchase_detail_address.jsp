<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="address_area">
    <h3>배송지</h3>
    <hr>
    
    <div >
        <label>
            <input type="radio" name="addrOption" value="DEFAULT" checked 
                   onclick="toggleAddr('DEFAULT')"> 기본 배송지
        </label>
        <label style="margin-left: 15px;">
            <input type="radio" name="addrOption" value="NEW" 
                   onclick="toggleAddr('NEW')"> 직접 입력
        </label>
    </div>

    <div id="addr_DEFAULT" class="addr_box" >
        <p><strong>받는사람:</strong> ${users.user_name}</p>
        <p><strong>연락처:</strong> ${users.user_tel}</p>
        <p><strong>주소:</strong> ${users.user_add}</p>
        
        <input type="hidden" name="order_name" value="${users.user_name}">
        <input type="hidden" name="order_tel" value="${users.user_tel}">
        <input type="hidden" name="order_add" value="${users.user_add}">
    </div>

    <div id="addr_NEW" class="addr_box" >
        <div >
            <input type="text" name="order_name_new" id="new_name" placeholder="받는사람">
        </div>
        <div >
            <input type="text" name="order_tel_new" id="new_tel" placeholder="010-0000-0000">
        </div>
        <div >
            <input type="text" id="sample6_postcode" placeholder="우편번호">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample6_address" placeholder="주소"><br>
			<input type="text" id="sample6_detailAddress" placeholder="상세주소">
			<input type="text" id="sample6_extraAddress" placeholder="참고항목">
        </div>
    </div>
</div>
<div class="delivery_memo_area">
    <label><strong>배송 메모</strong></label><br>
    <select name="delivery_memo_select" id="delivery_memo_select" onchange="toggleMemoInput()">
        <option value="">배송 메모를 선택해주세요</option>
        <option value="direct">직접 입력</option>
        <option value="배송 전 미리 연락 바랍니다.">배송 전 미리 연락 바랍니다.</option>
        <option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
        <option value="부재 시 문 앞에 놓아주세요.">부재 시 문 앞에 놓아주세요.</option>
        <option value="택배함에 보관해 주세요.">택배함에 보관해 주세요.</option>
        
    </select>
    
    <div id="direct_memo_div" >
        <input type="text" name="delivery_memo_direct" id="delivery_memo_direct" 
               placeholder="배송 메모를 직접 입력하세요(최대 50자)" >
    </div>
</div>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
/**
 * 배송지 선택에 따른 영역 전환
 */
function toggleAddr(type) {
    // 1. 모든 배송지 박스 숨김
    document.querySelectorAll('.addr_box').forEach(el => {
        el.style.display = 'none';
    });

    // 2. 선택된 타입(DEFAULT/NEW)의 박스만 노출
    document.getElementById('addr_' + type).style.display = 'block';
    
    // 3. (선택사항) 직접 입력 선택 시 입력창에 포커스
    if(type === 'NEW') {
        document.getElementById('new_name').focus();
    }
}

//카카오 주소 API
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


//배송지 선택에 따른 영역 전환	
function toggleAddr(type) {
    // 모든 배송지 박스 숨김
    document.querySelectorAll('.addr_box').forEach(el => {
        el.style.display = 'none';
    });

    // 선택된 타입(DEFAULT/NEW)의 박스만 노출
    document.getElementById('addr_' + type).style.display = 'block';
    
    // (선택사항) 직접 입력 선택 시 입력창에 포커스
    if(type === 'NEW') {
        document.getElementById('new_name').focus();
    }
}

//배송 메모 제어 함수
function toggleMemoInput() {
    const selectBox = document.getElementById("delivery_memo_select");
    const directDiv = document.getElementById("direct_memo_div");
    
    if (selectBox.value === "direct") {
        // '직접 입력' 선택 시 입력창 노출
        directDiv.style.display = "block";
        document.getElementById("delivery_memo_direct").focus();
    } else {
        // 다른 옵션 선택 시 입력창 숨김 및 값 초기화
        directDiv.style.display = "none";
        document.getElementById("delivery_memo_direct").value = "";
    }
}

function orderFormOK() {
    // 현재 선택된 배송지 옵션 확인
    const addrOption = document.querySelector('input[name="addrOption"]:checked').value;

    if (addrOption === 'NEW') {
        // 1. 이름 검증 (한글 2~5자)
        const name = document.getElementById("new_name").value;
        const regName = /^[가-힣]{2,5}$/;
        if (!regName.test(name)) {
            alert("받는 사람 이름을 한글 2~5자 이내로 입력해주세요.");
            document.getElementById("new_name").focus();
            return false;
        }

        // 2. 전화번호 검증 (하이픈 자동 제거 후 형식 확인)
        const telInput = document.getElementById("new_tel").value;
        const cleanTel = telInput.replace(/-/g, ''); 
        const regTel = /^(01[016789]|02|0[3-9][0-9])\d{3,4}\d{4}$/;
        if (!regTel.test(cleanTel)) {
            alert("올바른 전화번호 형식이 아닙니다.");
            document.getElementById("new_tel").focus();
            return false;
        }

        // 3. 주소 검증 (우편번호 및 상세주소 입력 확인)
        const postcode = document.getElementById("sample6_postcode").value.trim();
        const detail = document.getElementById("sample6_detailAddress").value.trim();
        if (postcode === "" || detail === "") {
            alert("배송지 주소와 상세주소를 모두 입력해주세요.");
            if(postcode === "") sample6_execDaumPostcode();
            else document.getElementById("sample6_detailAddress").focus();
            return false;
        }
    }
    
    // 배송 메모 직접 입력 시 검증
    const memoSelect = document.getElementById("delivery_memo_select").value;
    if (memoSelect === "direct") {
        const directMemo = document.getElementById("delivery_memo_direct").value.trim();
        if (directMemo === "") {
            alert("배송 메모를 입력해주세요.");
            document.getElementById("delivery_memo_direct").focus();
            return false;
        }
    }

    return true; // 모든 검증 통과 시 전송
}


</script>
