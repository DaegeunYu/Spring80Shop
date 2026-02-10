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
    
    // PortOne 결제 영수증 정보
    private String receiptId;       // [영수증 번호] 포트원 고유 번호 (환불/조회 시 사용)
    private String approvalId;      // [카드 승인 번호] 카드사 실제 거래 증명 번호
    private String approvalDate;    // [승인 일시] 주문일과 별개로 결제가 실제로 완료된 시각 
    private int paidAmount;         // [실제 결제 금액] 고객이 결제창에 입력해 승인된 금액, DB에 저장된 '주문 금액'과 '실제 낸 돈'을 비교
    private String pgStatus;       // 포트원 응답 상태 (PAID, READY, FAILED, CANCELLED 등)
    private int cancelAmount;      // 취소된 금액 (기본값 0)
    
}

