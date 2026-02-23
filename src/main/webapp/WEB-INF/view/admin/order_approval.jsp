<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
    /* 테이블 내부 삽입 시 발생하는 여백과 너비 제한 강제 해제 */
    #listBody { display: block !important; width: 100% !important; }
    #adminTable { display: block !important; border: none !important; }
    .approval-container { width: 100% !important; min-width: 1110px; } 
</style>

<td colspan="10" class="p-0 border-none block w-full">
    <div class="approval-container p-2">
        
        <div class="mb-8">
            <div class="bg-white rounded-[1.5rem] p-10 shadow-xl shadow-gray-200/40 border border-gray-100 flex justify-between items-center transition-all">
                <div>
                    <h4 class="text-sm font-bold text-gray-500 mb-2">입금 대기 건수</h4>
                    <div class="text-4xl font-black text-amber-500 flex items-baseline">
                        <c:out value="${approvalList.size()}" />
                        <span class="text-xl font-bold text-gray-400 ml-2">건</span>
                    </div>
                </div>
                <div class="text-right">
                	<p class="text-[20px] text-gray-400 font-medium leading-relaxed">
                        미승인 계좌이체 주문 내역입니다.<br>
                        입금 확인 후 하단 목록에서 승인 처리를 진행해 주세요.
                    </p>
                </div>
            </div>
        </div>

        <div class="flex gap-4 mb-6 items-stretch">
            <div class="flex-1 bg-white rounded-[1.5rem] shadow-xl shadow-gray-200/40 border border-gray-100 p-6 flex items-center">
                <h4 class="text-lg font-bold text-gray-800">계좌이체 승인 대기 목록</h4>
            </div>
            <button type="button" onclick="approveSelectedOrders()"
                class="px-10 py-5 bg-blue-600 text-white text-sm font-black rounded-[1.5rem] hover:bg-blue-700 transition-all shadow-lg shadow-blue-200 flex items-center gap-2">
                <i class="fas fa-check-circle text-lg"></i>
                <span>선택 항목 승인</span>
            </button>
        </div>

        <div class="bg-white rounded-[1.5rem] shadow-xl shadow-gray-200/40 border border-gray-100 overflow-hidden">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-gray-50/80 border-b border-gray-100">
                        <th class="py-5 pl-8 w-[80px] text-center">
                            <input type="checkbox" id="checkAll" onclick="toggleAllChecks(this)"
                                class="w-5 h-5 rounded border-gray-300 text-blue-600 cursor-pointer">
                        </th>
                        <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider">주문번호</th>
                        <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider">주문자 ID</th>
                        <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider">주문상품</th>
                        <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider">결제금액</th>
                        <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider text-center">관리</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-50">
                    <c:choose>
                        <c:when test="${not empty approvalList}">
                            <c:forEach var="order" items="${approvalList}">
                                <tr class="hover:bg-blue-50/30 transition-colors">
                                    <td class="py-5 pl-8 text-center">
                                        <input type="checkbox" name="orderCheck" value="${order.orderCode}"
                                            class="w-5 h-5 rounded border-gray-300 text-blue-600 cursor-pointer">
                                    </td>
                                    <td class="px-6 py-5 text-sm font-bold text-gray-900">${order.orderCode}</td>
                                    <td class="px-6 py-5 text-sm text-gray-600">${order.userId}</td>
                                    <td class="px-6 py-5 text-sm text-gray-600">${order.productName}</td>
                                    <td class="px-6 py-5 text-sm font-black text-blue-600">
                                        <fmt:formatNumber value="${order.paidAmount}" type="number" />원
                                    </td>
                                    <td class="px-6 py-5 text-center">
                                        <button type="button" onclick="confirmApproval('${order.orderCode}')"
                                            class="px-5 py-2 bg-blue-600 text-white text-xs font-bold rounded-lg hover:bg-blue-700 hover:text-white transition-all whitespace-nowrap">
                                            승인 처리
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="px-6 py-32 text-center text-gray-400 text-sm font-medium">
                                    <i class="fas fa-inbox text-4xl mb-4 block opacity-20"></i>
                                    현재 승인 대기 중인 내역이 없습니다.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</td>



<script>
function toggleAllChecks(mainCheck) {
    const checks = document.querySelectorAll('input[name="orderCheck"]');
    checks.forEach(check => check.checked = mainCheck.checked);
}

function approveSelectedOrders() {
    const selectedChecks = document.querySelectorAll('input[name="orderCheck"]:checked');
    if (selectedChecks.length === 0) {
        alert("승인할 주문을 선택해주세요.");
        return;
    }
    if (!confirm("선택한 " + selectedChecks.length + "건을 승인하시겠습니까?")) return;

    const orderCodes = Array.from(selectedChecks).map(check => check.value);
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/approveBulkOrders.do",
        type: "POST",
        traditional: true,
        data: { "orderCodes": orderCodes },
        success: function(response) {
            // 성공일 때만 페이지를 갱신
            if (response.trim() === "success") {
                alert("선택 항목 승인되었습니다.");
                if (typeof loadContent === 'function') {
                    loadContent('order_approval');
                } else {
                    location.reload();
                }
            } else {
                // 실패나 오류 시 리로드하지 않고 경고창
                alert("일부 항목 승인 중 오류가 발생했습니다. 목록을 확인해 주세요.");
            }
        },
        error: function() {
            alert("서버 통신 중 에러가 발생했습니다.");
        }
    });
}

function confirmApproval(orderCode) {
    if (!confirm("해당 주문을 승인하시겠습니까?")) return;
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/approveOrder.do",
        type: "POST",
        data: { "orderCode": orderCode },
        success: function(response) {
            if (response.trim() === "success") {
                alert("승인되었습니다.");
                if (typeof loadContent === 'function') loadContent('order_approval');
                else location.reload();
            }
        }
    });
}
</script>