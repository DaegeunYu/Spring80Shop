<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="payment_area">
    <h3>결제 수단</h3>
    <hr>
    			   <!-- radio: 여러옵션중 하나만 선택, name속성이 같을경우 하나의 그룹으로 묶음, value는 하나만 선택됨 -->
    <label><input type="radio" name="paymentMethod" value="CARD" checked onclick="updateStatus('결제완료', 'CARD')"> 신용카드</label>
    <label><input type="radio" name="paymentMethod" value="BANK" onclick="updateStatus('결제대기', 'BANK')"> 계좌이체</label>

    <div id="display_CARD" class="payment_info" style="display: block;"><br>카드 결제 시스템을 이용합니다.</div>
    <div id="display_BANK" class="payment_info" style="display: none;"><br>계좌번호: 80's 커피은행 123-456-789012</div>
    
    <input type="hidden" name="paymentStatus" id="paymentStatus" value="결제완료">
    
    <button type="button" class="btn_payment" onclick="requestPayment()">결제하기</button>
</div>



<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script>

//OrderAmountDTO의 배송비 입력값 적용
const SERVER_DELIVERY_FEE = <%= com.eighty.purchase.OrderAmountDTO.POLICY_DELIVERY_FEE %>;

//라디오 버튼 처리 함수
function updateStatus(status, method) {
    document.getElementById("paymentStatus").value = status;
    document.querySelectorAll('.payment_info').forEach(el => el.style.display = 'none');
    document.getElementById('display_' + method).style.display = 'block';
}

function updateOrAppendField(form, name, value) {
    // 폼 안에 해당 name을 가진 input이 이미 있는지 확인
    let input = form.querySelector('input[name="' + name + '"]');
    if (input) {
        input.value = value; // 존재하면 값만 변경 (쉼표 발생 차단)
    } else {
        // 존재하지 않을 때만 새로 생성
        input = document.createElement("input");
        input.type = "hidden";
        input.name = name;
        input.value = value;
        form.appendChild(input);
    }
}

async function requestPayment() {
    // 유효성 검사
    if (typeof orderFormOK === "function") {
        if (!orderFormOK()) return;
    }
    
    // 가격 계산
    const rawPrice = "${final_total_price}";
    const totalAmount = Number(rawPrice.replace(/[^0-9]/g, "").trim());

 	// 선택된 결제 수단(CARD 또는 BANK)을 가져옴
    const selectedMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
    const form = document.querySelector("form");
    
    // 계좌이체(BANK)인 경우, 포트원 창을 띄우지 않고 바로 폼을 보냄
    if (selectedMethod === "BANK") {
        if(confirm("계좌이체로 주문하시겠습니까?")) {
            const form = document.querySelector("form");
            // 계좌이체는 승인번호가 없으므로 임시값 세팅
            updateOrAppendField(form, "receiptId", "BANK_" + new Date().getTime());
            updateOrAppendField(form, "approvalId", "WAIT_DEPOSIT"); // 400 에러 방지용
            updateOrAppendField(form, "paidAmount", totalAmount);
            updateOrAppendField(form, "pgStatus", "READY"); 
            updateOrAppendField(form, "approvalDate", "N/A");
            form.submit();
            return;
        }
    }

    // 카드 결제일 때만 포트원 실행
    const orderCode = ("${orderCode}").trim();

    try {
        var response = await PortOne.requestPayment({
            storeId: "store-7a69bf30-b0a8-4361-adab-3c3dc4dee02d",
            channelKey: "channel-key-bf38e182-d92e-488b-bba6-df1880e87293",
            paymentId: orderCode + "_" + new Date().getTime(),
            orderName: "80's 원두 외 상품",
            totalAmount: totalAmount,
            currency: "CURRENCY_KRW",
            payMethod: selectedMethod, // "CARD" 대신 선택된 값 전달
            customer: { 
                fullName: ("${users.user_name}").trim(), 
                email: ("${users.user_email}").trim(), 
                phoneNumber: ("${users.user_tel}").trim() 
            }
        });

        if (response.code != null) return alert("결제 실패: " + response.message);

        // 비동기 검증 요청
      const validation = await fetch("${pageContext.request.contextPath}/purchase/purchase_success.do", {
   		 method: "POST", 
   		 headers: { "Content-Type": "application/json" },
   		 body: JSON.stringify({ 
       		 paymentId: response.paymentId, 
       		 amount: totalAmount 
  		  })
	  });

        var result = await validation.text();
        
     	// 검증 결과가 "success"인 경우, 상세 정보를 폼에 담아 최종 전송
        if (result.includes("success")) {
            const form = document.querySelector("form");
            
            updateOrAppendField(form, "paymentStatus", "결제완료");

            // 컨트롤러의 @RequestParam 명칭과 정확히 일치시켜 데이터 주입
            updateOrAppendField(form, "receiptId", response.paymentId); // 포트원 고유 결제번호
            updateOrAppendField(form, "approvalId", response.txId || "N/A"); // 카드 승인번호 (없을 시 N/A)
            updateOrAppendField(form, "paidAmount", totalAmount); // 실제 결제 금액
            updateOrAppendField(form, "pgStatus", "PAID"); // 결제 상태
            updateOrAppendField(form, "approvalDate", new Date().toLocaleString()); // 승인 일시

            // 최종 폼 서브밋 (purchase_insert.do 호출)
            form.submit();
        } else {
            alert("검증 실패: " + result);
        }

    } catch (e) {
        alert("시스템 오류 발생");
        console.error(e);
    }
}
</script>