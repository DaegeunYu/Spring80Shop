<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="p-2">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        
        <div class="bg-white rounded-[1.5rem] p-7 shadow-xl shadow-gray-200/40 border border-gray-100 flex flex-col justify-between transition-all hover:-translate-y-1">
            <div>
                <div class="flex items-center gap-2 mb-4">
                </div>
                <h4 class="text-sm font-bold text-gray-500 mb-1">총 매출액</h4>
                <div class="text-3xl font-black text-gray-900">
                    <fmt:formatNumber value="${summary.GROSS_SALES}" type="number"/>
                    <span class="text-lg font-bold text-gray-400 ml-1">원</span>
                </div>
            </div>
            <div class="mt-4 pt-4 border-t border-gray-50">
                <p class="text-[11px] text-gray-400 font-medium">배송비 포함 결제 총합</p>
            </div>
        </div>

        <div class="bg-white rounded-[1.5rem] p-7 shadow-xl shadow-gray-200/40 border border-gray-100 flex flex-col justify-between transition-all hover:-translate-y-1">
            <div>
                <div class="flex items-center gap-2 mb-4">
                </div>
                <h4 class="text-sm font-bold text-gray-500 mb-1">순 상품 매출</h4>
                <div class="text-3xl font-black text-gray-900">
                    <fmt:formatNumber value="${summary.NET_SALES}" type="number"/>
                    <span class="text-lg font-bold text-gray-400 ml-1">원</span>
                </div>
            </div>
            <div class="mt-4 pt-4 border-t border-gray-50">
                <p class="text-[11px] text-gray-400 font-medium">배송비 제외 순수 물건값</p>
            </div>
        </div>

        <div class="bg-white rounded-[1.5rem] p-7 shadow-xl shadow-gray-200/40 border border-gray-100 flex flex-col justify-between transition-all hover:-translate-y-1">
            <div>
                <div class="flex items-center gap-2 mb-4">
                </div>
                <h4 class="text-sm font-bold text-gray-500 mb-1">평균 객단가(ATV)</h4>
                <div class="text-3xl font-black text-gray-900">
                    <fmt:formatNumber value="${summary.ATV}" type="number" maxFractionDigits="0"/>
                    <span class="text-lg font-bold text-gray-400 ml-1">원</span>
                </div>
            </div>
            <div class="mt-4 pt-4 border-t border-gray-50">
                <p class="text-[11px] text-gray-400 font-medium">주문 1건당 평균 결제액</p>
            </div>
        </div>

		<div class="bg-white rounded-[1.5rem] p-7 shadow-xl shadow-gray-200/40 border border-gray-100 flex flex-col justify-between transition-all hover:-translate-y-1">
            <div>
                <div class="flex items-center gap-2 mb-4"></div>
                <h4 class="text-sm font-bold text-gray-500 mb-1">전체 주문건수</h4>
                <div class="text-3xl font-black text-gray-900">
                    <fmt:formatNumber value="${summary.TOTAL_ORDERS}" type="number"/>
                    <span class="text-lg font-bold text-gray-400 ml-1">건</span>
                </div>
            </div>
            <div class="mt-4 pt-4 border-t border-gray-50">
                <p class="text-[11px] text-gray-400 font-medium">결제 완료된 주문 일련번호 기준</p>
            </div>
        </div>

		<div
			class="bg-white rounded-[1.5rem] p-7 shadow-xl shadow-gray-200/40 border border-gray-100 flex flex-col justify-between transition-all hover:-translate-y-1">
			<div>
				<h4 class="text-sm font-bold text-gray-500 mb-4">결제수단 비중</h4>

				<div class="space-y-4">
					<div class="flex justify-between items-center">
						<div class="flex items-center gap-2">
							<div class="w-2 h-2 bg-blue-500 rounded-full"></div>
							<span class="text-sm font-bold text-gray-700">카드결제
								${summary.CARD_CNT}건</span>
						</div>
						<span class="text-sm font-black text-blue-600"> <c:if
								test="${summary.TOTAL_ORDERS > 0}">
								<fmt:formatNumber
									value="${summary.CARD_CNT / summary.TOTAL_ORDERS}"
									type="percent" maxFractionDigits="0" />
							</c:if>
						</span>
					</div>

					<div class="flex justify-between items-center">
						<div class="flex items-center gap-2">
							<div class="w-2 h-2 bg-amber-400 rounded-full"></div>
							<span class="text-sm font-bold text-gray-700">계좌이체
								${summary.BANK_CNT}건</span>
						</div>
						<span class="text-sm font-black text-amber-500"> <c:if
								test="${summary.TOTAL_ORDERS > 0}">
								<fmt:formatNumber
									value="${summary.BANK_CNT / summary.TOTAL_ORDERS}"
									type="percent" maxFractionDigits="0" />
							</c:if>
						</span>
					</div>

					<c:if test="${summary.TOTAL_ORDERS > 0}">
						<div
							class="w-full h-2 bg-gray-100 rounded-full flex overflow-hidden mt-2">
							<div
								style="width: ${(summary.CARD_CNT * 1.0 / summary.TOTAL_ORDERS) * 100}%"
								class="bg-blue-500"></div>
							<div
								style="width: ${(summary.BANK_CNT * 1.0 / summary.TOTAL_ORDERS) * 100}%"
								class="bg-amber-400"></div>
						</div>
					</c:if>
				</div>
			</div>
			<div class="mt-4 pt-4 border-t border-gray-50">
				<p class="text-[11px] text-gray-400 font-medium">수단별 결제 분포</p>
			</div>
		</div>



	</div>

    <c:if test="${summary.TOTAL_ORDERS == 0}">
        <div class="bg-gray-100 rounded-2xl p-10 text-center">
            <i class="fas fa-chart-pie text-gray-300 text-4xl mb-4"></i>
            <p class="text-gray-500 font-bold">현재 산출된 매출 데이터가 없습니다.</p>
        </div>
    </c:if>
</div>