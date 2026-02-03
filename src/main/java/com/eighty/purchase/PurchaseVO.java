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
    
    // 배송을 위한 수령인 정보 추가, 결제 수단 추가
    private String receiverName;    // 수령인 성명
    private String receiverPhone;   // 수령인 연락처
    private String address;         // 합쳐진 주소 (기본+상세+참고)
    private String orderMemo;       // 배송 요청사항
    private String paymentMethod;   // 결제 수단 (기본값: CARD)
}

