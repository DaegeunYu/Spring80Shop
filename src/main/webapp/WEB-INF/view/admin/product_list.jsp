<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="item" items="${productList}">
    <tr class="hover:bg-gray-50/80 transition-colors border-b border-gray-50 last:border-0 group">
        
        <td class="px-6 py-4">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-lg bg-gray-100 overflow-hidden flex-shrink-0 border border-gray-200">
                    <img src="${item.product_img}" 
                         onerror="this.src='https://via.placeholder.com/40?text=No+Img'"
                         class="w-full h-full object-cover">
                </div>
                <span class="font-bold text-gray-800">${item.product_name}</span>
            </div>
        </td>

        <td class="px-6 py-4 text-sm text-gray-600 font-medium">
            ${item.origin}
        </td>

        <td class="px-6 py-4 text-sm text-gray-500">
            ${item.manufacturing}
        </td>

        <td class="px-6 py-4 text-center">
            <span class="inline-block px-2.5 py-1 rounded-md text-[11px] font-black
                ${item.roast_dgree == '강배전' ? 'bg-orange-100 text-orange-700' : 
                  item.roast_dgree == '중배전' ? 'bg-yellow-100 text-yellow-700' : 'bg-green-100 text-green-700'}">
                ${item.roast_dgree}
            </span>
        </td>

        <td class="px-6 py-4 font-bold text-gray-700">
            <fmt:formatNumber value="${item.sale_price}" type="number"/>원
        </td>

        <td class="px-6 py-4">
            <div class="flex items-center gap-2">
                <span class="text-sm font-bold ${item.quantity < 10000 ? 'text-red-500' : 'text-gray-600'}">
                    ${item.quantity}
                </span>
            </div>
        </td>

        <td class="px-6 py-4 text-right">
            <div class="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 hover:bg-blue-50 text-blue-600 rounded-md transition-colors" title="수정">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="p-2 hover:bg-red-50 text-red-600 rounded-md transition-colors" title="삭제">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </div>
        </td>
    </tr>
</c:forEach>

<c:if test="${empty productList}">
    <tr>
        <td colspan="7" class="py-20 text-center text-gray-400 font-medium">
            등록된 상품 정보가 없습니다.
        </td>
    </tr>
</c:if>