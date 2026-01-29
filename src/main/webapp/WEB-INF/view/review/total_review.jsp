<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="review-stats-container">
    
    <div class="stat-item">
        <div class="stat-label">사용자 총 평점</div>
        
        <div class="star-box">
            <div class="total-star-rating large">
                <span>★★★★★</span>
                <div class="total-star-fill" style="width: ${param.totalAvg * 20}%;">
                    <span>★★★★★</span>
                </div>
            </div>
            
            <div class="stat-value">
                <fmt:formatNumber value="${param.totalAvg}" pattern="0.0"/>
                <small>/ 5</small>
            </div>
        </div>
    </div>

    <div class="stat-item">
        <div class="stat-label">전체 리뷰수</div>
        
        <div class="icon-box">
            <img src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/review_record.png" 
                 class="review-icon-img">
        </div>
        
        <div class="stat-value">
            ${param.reviewCount}
        </div>
    </div>
</div>