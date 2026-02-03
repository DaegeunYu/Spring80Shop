package com.eighty.basket;

import lombok.Data;

@Data
public class RecentVO {
    private Long idx;
    private String user_id;
    private String product_code;
    private String product_name;
    private String product_img;
    private Long number;
}