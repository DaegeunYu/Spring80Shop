package com.eighty.purchase;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data                
@NoArgsConstructor
@AllArgsConstructor  // 모든 필드를 파라미터로 받는 생성자 (선택 사항)
public class PurchaseVO {
	
    private Long idx;
    private String order_code;
    private String user_id;
    private String product_code;
    private String product_name;
    private String product_weight;
    private String crushing;
    private String order_price;
    private String order_count;
    private String order_status;
    private String order_date;
    private String is_review;
}