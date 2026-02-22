<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="avgScore" value="${empty param.totalAvg ? 0.0 : param.totalAvg}" />
<c:set var="rvCount" value="${empty param.reviewCount ? 0 : param.reviewCount}" />

<div class="review-stats-container">
    
    <div class="stat-item">
        <div class="stat-label">사용자 총 평점</div>
        
        <div class="star-box">
        	<c:choose>
        		<c:when test="${rvCount > 0}">
            		<div class="total-star-rating large">
                		<span>★★★★★</span>
                		<div class="total-star-fill" style="width: ${avgScore * 20}%;">
                    		<span>★★★★★</span>
                		</div>
            		</div>
            
            		<div class="stat-value">
		                <fmt:formatNumber value="${avgScore}" pattern="0.0"/>
		                <small>/ 5</small>
            		</div>
            	</c:when>
            	
            	<c:otherwise>
                    <div class="total-star-rating large" style="color: #ddd;">
                        <span>★★★★★</span> 
                    </div>
                    <div class="stat-value">
                        0.0 <small>/ 5</small>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="stat-item">
        <div class="stat-label">전체 리뷰수</div>
        
        <div class="icon-box">
            <img src="${pageContext.request.contextPath}/resources/files/common/review_record.png" 
                 class="review-icon-img">
        </div>
        
        <div class="stat-value">
            ${rvCount}
        </div>
    </div>
</div>