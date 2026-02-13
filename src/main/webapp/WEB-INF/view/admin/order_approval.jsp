<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="p-2">
	<div class="mb-8">
		<div
			class="bg-white rounded-[1.5rem] p-7 shadow-xl shadow-gray-200/40 border border-gray-100 transition-all max-w-sm">
			<h4 class="text-sm font-bold text-gray-500 mb-1">입금 대기 건수</h4>
			<div class="text-3xl font-black text-amber-500">
				<c:out value="${approvalList.size()}" />
				<span class="text-lg font-bold text-gray-400 ml-1">건</span>
			</div>
			<p class="text-[11px] text-gray-400 font-medium mt-4 pt-4 border-t">미승인
				계좌이체 주문 내역입니다.</p>
		</div>
	</div>

	<div
		class="bg-white rounded-[1.5rem] shadow-xl shadow-gray-200/40 border border-gray-100 overflow-hidden">
		<div class="p-6 border-b border-gray-50 bg-gray-50/30">
			<h4 class="text-lg font-bold text-gray-800">계좌이체 승인 대기 목록</h4>
		</div>

		<div
			class="px-6 py-4 border-b border-gray-50 flex justify-end bg-white">
			<button type="button" onclick="approveSelectedOrders()"
				class="px-5 py-2.5 bg-blue-600 text-white text-[11px] font-black rounded-xl hover:bg-blue-700 transition-all shadow-lg shadow-blue-200 flex items-center gap-2">
				<span>✓</span> 선택항목 일괄 승인
			</button>
		</div>

		<div class="overflow-x-auto">
			<table class="w-full text-left border-collapse">
				<thead>
					<tr class="bg-gray-50/80 border-b border-gray-100">
						<th class="py-4 pl-6 pr-0 w-[40px] text-center"><input
							type="checkbox" id="checkAll" onclick="toggleAllChecks(this)"
							class="w-4 h-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500 cursor-pointer">
						</th>
						<th
							class="px-4 py-4 text-xs font-bold text-gray-500 uppercase w-48">주문번호</th>
						<th
							class="px-4 py-4 text-xs font-bold text-gray-500 uppercase w-32">주문자
							ID</th>
						<th class="px-4 py-4 text-xs font-bold text-gray-500 uppercase">주문상품</th>
						<th
							class="px-4 py-4 text-xs font-bold text-gray-500 uppercase w-36">결제금액</th>
						<th
							class="px-4 py-4 text-xs font-bold text-gray-500 uppercase text-center w-24">관리</th>
					</tr>
				</thead>
				<tbody class="divide-y divide-gray-50">
					<c:choose>
						<c:when test="${not empty approvalList}">
							<c:forEach var="order" items="${approvalList}">
								<tr class="hover:bg-blue-50/30 transition-colors">
									<td class="py-4 pl-6 pr-0 text-center"><input
										type="checkbox" name="orderCheck" value="${order.orderCode}"
										class="w-4 h-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500 cursor-pointer">
									</td>
									<td class="px-4 py-4 text-sm font-bold text-gray-900">${order.orderCode}</td>
									<td class="px-4 py-4 text-sm text-gray-600">${order.userId}</td>
									<td class="px-4 py-4 text-sm text-gray-600">${order.productName}</td>
									<td class="px-4 py-4 text-sm font-black text-blue-600"><fmt:formatNumber
											value="${order.paidAmount}" type="number" />원</td>
									<td class="px-4 py-4 text-center">
										<button type="button"
											onclick="confirmApproval('${order.orderCode}')"
											class="px-3 py-1.5 bg-gray-100 text-gray-700 text-[10px] font-bold rounded-lg hover:bg-blue-600 hover:text-white transition-all whitespace-nowrap">
											승인</button>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6"
									class="px-6 py-20 text-center text-gray-400 text-sm">현재 대기
									중인 승인 내역이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
</div>

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
    if (!confirm("선택한 " + selectedChecks.length + "건을 일괄 승인하시겠습니까?")) return;

    const orderCodes = Array.from(selectedChecks).map(check => check.value);
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/approveBulkOrders.do",
        type: "POST",
        traditional: true,
        data: { "orderCodes": orderCodes },
        success: function(response) {
            if (response.trim() === "success") {
                alert("일괄 승인되었습니다.");
                if (typeof loadContent === 'function') loadContent('order_approval');
                else location.reload();
            } else {
                alert("오류가 발생했습니다.");
            }
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