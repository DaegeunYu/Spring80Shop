package com.eighty.purchase;

import java.util.List;

public interface PurchaseService {
	   List<PurchaseVO> getPurchaseList(PurchaseVO vo);
	   public List<PurchaseVO> getPurchaseListSummary(String userId);
	   void insertPurchase(List<PurchaseVO> list); // 상품이 1개든 여러 개든 List에 담아서 처리
	   List<PurchaseVO> getPurchaseListOne(PurchaseVO vo);
	   int updateProductStock(PurchaseVO item); // 주문 시 재고 차감
	   
	   void updatePaymentInfo(PurchaseVO vo); // 결제 완료 후 포트원 영수증 정보를 DB에 업데이트하는 기능
	   boolean verifyPayment(String paymentId, int expectedPrice);
}