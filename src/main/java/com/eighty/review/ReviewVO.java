package com.eighty.review;

import lombok.Data;

@Data
public class ReviewVO {
    private Long idx;
    private String userId;
    private String orderCode;
    private String productCode;
    private String gradePoint;
    private String reviewTitle;
    private String reviewContent;
    private String reviewImg;
    private String regDate;
}
