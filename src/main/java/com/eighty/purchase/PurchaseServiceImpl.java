package com.eighty.purchase;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	private PurchaseDao  dao;

	@Override
	public List<PurchaseVO> getPurchaseList(PurchaseVO vo) {
		return dao.getPurchaseList(vo);
	}
	
	@Override
    public List<PurchaseVO> getPurchaseListSummary(String userId) {
        return dao.getPurchaseListSummary(userId);
    }

	@Override
	public void insertPurchase(List<PurchaseVO> list) {
		dao.insertPurchase(list);
		
	}

	@Override
	public List<PurchaseVO> getPurchaseListOne(PurchaseVO vo) {
		return dao.getPurchaseListOne(vo);
	}

	@Override
	public void updatePaymentInfo(PurchaseVO vo) {
		dao.updatePaymentInfo(vo);		
	}
	
	public boolean verifyPayment(String paymentId, int expectedPrice) {
	    return false; // 금액이 다르거나 결제되지 않았으면 실패 처리
	}

	@Override
	public int updateProductStock(PurchaseVO item) {
		return dao.updateProductStock(item);
	}
}
