package com.eighty.review;

import lombok.Data;

@Data
public class ReviewVO {
    private Long idx;
    private String user_id;
    private String order_code;
    private String product_code;
    private String grade_point;
    private String review_title;
    private String review_content;
    private String review_img;
    private String reg_date;
}
