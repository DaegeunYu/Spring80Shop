<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/review.css">

<table class="review-table">
    <thead>
        <tr>
            <th>평점</th>
            <th width="50%">제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="review" items="${review_list}">
            <tr class="title-row" onclick="toggleReview('${review.idx}')">
                <td>
                    <span class="star">
                        <c:forEach var="i" begin="1" end="5">
                            <c:choose>
                                <%-- grade_point 변수명에 맞춤 --%>
                                <c:when test="${i <= review.grade_point}">★</c:when>
                                <c:otherwise><span class="star-off">★</span></c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </span>
                </td>
                <%-- review_title 변수명에 맞춤 --%>
                <td style="text-align: left;">${review.review_title}</td>
                <td>${review.user_id}</td>
                <%-- reg_date 변수명에 맞춤 --%>
                <td>${review.reg_date}</td>
            </tr>

            <tr id="detail-${review.idx}" class="detail-row">
                <td colspan="4">
                    <div class="detail-content">
                        <strong>[상세 후기]</strong><br>
                        <%-- review_content 변수명에 맞춤 --%>
                        ${review.review_content}
                        
                        <%-- review_img 변수명에 맞춤 --%>
                        <c:if test="${not empty review.review_img}">
						    <img src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/${review.review_img}" class="review-img">
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