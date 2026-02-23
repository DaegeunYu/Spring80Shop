package com.eighty.purchase;

public class OrderAmountDTO {
	
	public static final int POLICY_DELIVERY_FEE = 5000; // 여기만 수정하면 배송비 전체 적용
	
	// final int: 상수로 고정, 데이터 오염 방지, 외부에서 접근 및 수정 불가
	private final int totalProductPrice; // 순수 상품 가격의 합계
    private final int deliveryFee;       // 배송비 정책에 따른 결과값
    private final int finalPaidAmount;   // 실제 결제가 이루어질 최종 금액
    
    
    
    public OrderAmountDTO(int totalProductPrice) {
        // 상품가격 합계 
        this.totalProductPrice = totalProductPrice;

        // 배송비 결정 (상품이 있으면 5000원, 없으면 0원), 배송비 수정 시 전체 적용
        this.deliveryFee = (totalProductPrice > 0) ? POLICY_DELIVERY_FEE : 0;

        // 최종 금액 계산
        this.finalPaidAmount = this.totalProductPrice + this.deliveryFee;
        
    }

    // 외부에서 가격을 수정 할 수 없도록 Getter(읽기 권한)만 설정
    public int getTotalProductPrice() { return totalProductPrice; }
    public int getDeliveryFee() { return deliveryFee; }
    public int getFinalPaidAmount() { return finalPaidAmount; }
}
