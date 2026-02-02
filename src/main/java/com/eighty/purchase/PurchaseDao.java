package com.eighty.purchase;

import java.util.List;

public interface PurchaseDao {
	   List<PurchaseVO> getPurchaseList(PurchaseVO vo);
	   void insertPurchase(List<PurchaseVO> list); // 상품이 1개든 여러 개든 List에 담아서 처리
}
