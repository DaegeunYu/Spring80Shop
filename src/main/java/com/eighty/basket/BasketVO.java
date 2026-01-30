package com.eighty.basket;

import lombok.Data;

@Data
public class BasketVO {
    private Long idx;
    private String user_id;
    private String product_code;
    private String product_name;
    private String product_img;
    private String product_weight;
    private String crushing;
    private String product_count;
    private String basket_price;
    private String basket_date;
}