<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="payment_area">
    <h3>결제 수단</h3>
    <hr>
    			   <!-- radio: 여러옵션중 하나만 선택, name속성이 같을경우 하나의 그룹으로 묶음, value는 하나만 선택됨 -->
    <label><input type="radio" name="paymentMethod" value="CARD" checked onclick="updateStatus('COMPLETED', 'CARD')"> 신용카드</label>
    <label><input type="radio" name="paymentMethod" value="BANK" onclick="updateStatus('WAITING', 'BANK')"> 계좌이체</label>

    <div id="display_CARD" class="payment_info" ><br>카드 결제 시스템을 이용합니다.</div>
    <div id="display_BANK" class="payment_info" ><br>계좌번호: 80커피은행 123-456-789012</div>

    <input type="hidden" id="paymentStatus" name="paymentStatus" value="COMPLETED">
    
    <button type="button" onclick="submitPayment()">결제하기</button>
</div>

<script>
function updateStatus(status, method) {
    document.getElementById("paymentStatus").value = status;
    document.querySelectorAll('.payment_info').forEach(el => el.style.display = 'none');
    document.getElementById('display_' + method).style.display = 'block';
}

function submitPayment() {
    if(confirm("결제를 진행하시겠습니까?")) {
        document.getElementById("orderForm").submit();
    }
}
</script>