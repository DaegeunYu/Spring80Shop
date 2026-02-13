<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/review.css">


<table class="review-table" id="review-section">
    <thead>
        <tr>
            <th>평점</th>
            <th width="50%">제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="review" items="${reviewList}">
            <tr class="title-row" onclick="toggleReview('${review.idx}')">
                <td>
                    <span class="star">
                        <c:forEach var="i" begin="1" end="5">
                            <c:choose>
                                <c:when test="${i <= review.gradePoint}">★</c:when>
                                <c:otherwise><span class="star-off">★</span></c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </span>
                </td>
                <td style="text-align: left;">${review.reviewTitle}</td>
                <td><a href="/review/reviewEdit.do?userId=${review.userId}">${review.userId}</a></td>
                <td>${review.regDate}</td>
            </tr>

            <tr id="detail-${review.idx}" class="detail-row">
                <td colspan="4">
                    <div class="detail-content">
                        <strong>[상세 후기]</strong><br>
                        ${review.reviewContent}
                        <c:if test="${not empty review.reviewImg}">
						    <img src="${pageContext.request.contextPath}/resources/files/${review.reviewImg}"
						         class="review-img" alt="리뷰 이미지"
						         style="max-width: 200px; border-radius: 8px; margin-top: 10px;">
						</c:if>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function toggleReview(idx) {
    const target = $("#detail-" + idx);
    if (target.is(":visible")) {
        target.hide();
    } else {
        $(".detail-row").hide();
        target.show();
    }
}
</script>