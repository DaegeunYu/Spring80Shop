<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 상세 정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/popup.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="popup-wrapper">
        <h2>리뷰 상세 보기</h2>
        <hr>
        <table border="1" style="width:100%; border-collapse:collapse;">
            <tr>
                <th>번호</th><td>${review.idx}</td>
                <th>작성자</th><td>${review.userId}</td>
            </tr>
            <tr>
                <th>제목</th><td colspan="3">${review.reviewTitle}</td>
            </tr>
            <tr>
                <th>별점</th><td colspan="3">
                	<div class="flex justify-center items-center gap-0.5 text-yellow-400">
		                <c:forEach begin="1" end="5" var="i">
		                    <i class="${i <= review.gradePoint ? 'fas' : 'far'} fa-star text-[10px]"></i>
		                </c:forEach>		                
		            </div>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3" style="height:200px; vertical-align:top;">
                    <c:out value="${review.reviewContent}" />
                </td>
            </tr>
            <c:if test="${not empty review.reviewImg}">
                <tr>
                    <th>이미지</th>
                    <td colspan="3">
                        <img src="${pageContext.request.contextPath}/resources/files/${review.reviewImg}" style="max-width:100%;">
                    </td>
                </tr>
            </c:if>
        </table>
        
        <div style="text-align:center; margin-top:20px;">
            <button onclick="window.close()">창 닫기</button>
        </div>
    </div>
</body>
</html>