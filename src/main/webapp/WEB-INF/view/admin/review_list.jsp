<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="review" items="${reviewList}">
    <tr class="hover:bg-gray-50/80 transition-colors border-b border-gray-50 last:border-0 group">
        
        <td class="px-6 py-4">
            <span class="font-bold text-gray-800">${review.userId}</span>
        </td>

        <td class="px-6 py-4 text-sm text-gray-600">
            ${review.userName}
        </td>
        
        <td class="px-6 py-4 text-sm text-gray-400 font-medium">
            ${review.productCode}
        </td>

		<td class="px-6 py-4">
            <p class="text-sm text-gray-500 max-w-[200px] truncate" title="${review.reviewTitle}">
                ${review.reviewTitle}
            </p>
        </td>

        <td class="px-6 py-4 text-center">
            <div class="flex justify-center items-center gap-0.5 text-yellow-400">
                <c:forEach begin="1" end="5" var="i">
                    <i class="${i <= review.gradePoint ? 'fas' : 'far'} fa-star text-[10px]"></i>
                </c:forEach>
                <span class="ml-2 text-xs font-bold text-gray-500">${review.gradePoint}</span>
            </div>
        </td>

        <td class="px-6 py-4 text-sm text-gray-400">
            <c:choose>
                <c:when test="${not empty review.regDate}">
                    <fmt:parseDate value="${review.regDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedRevDate" />
                    <fmt:formatDate value="${parsedRevDate}" pattern="yyyy-MM-dd"/>
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </td>

        <td class="px-6 py-4 text-right">
            <div class="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                <button onclick="viewReviewDetail('${review.idx}')" class="p-2 hover:bg-gray-100 text-gray-500 rounded-md transition-colors" title="상세보기">
                    <i class="fas fa-search"></i>
                </button>
                <button onclick="deleteReview('${review.idx}')" class="p-2 hover:bg-red-50 text-red-600 rounded-md transition-colors" title="삭제">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </div>
        </td>
    </tr>
</c:forEach>

<c:if test="${empty reviewList}">
    <tr>
        <td colspan="7" class="py-20 text-center text-gray-400 font-medium">
            작성된 리뷰가 없습니다.
        </td>
    </tr>
</c:if>