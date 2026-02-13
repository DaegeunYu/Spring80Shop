package com.eighty.review;

import lombok.Data;

@Data
public class ReviewDTO {
    private Long idx;
    private String userId;
    private String userName;
    private String productCode;
    private String gradePoint;
    private String reviewTitle;
    private String reviewContent;
    private String regDate;
}
