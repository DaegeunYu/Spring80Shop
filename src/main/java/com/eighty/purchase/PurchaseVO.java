package com.eighty.purchase;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data                
@NoArgsConstructor
@AllArgsConstructor  // 모든 필드를 파라미터로 받는 생성자 (선택 사항)
public class PurchaseVO {
	
    private Long idx;
    private String orderCode;
    private String userId;
    private String productCode;
    private String productName;
    private String productWeight;
    private String crushing;
    private String orderPrice;
    private String orderCount;
    private String orderStatus;
    private String orderDate;
    private String isReview;
}