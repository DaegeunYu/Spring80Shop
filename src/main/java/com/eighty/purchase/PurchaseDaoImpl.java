package com.eighty.purchase;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public List<PurchaseVO> getPurchaseList(PurchaseVO vo) {
		return mybatis.selectList("PURCHASE.getPurchaseList", vo);
	}
	
	@Override
    public List<PurchaseVO> getPurchaseListSummary(String userId) {
        return mybatis.selectList("PURCHASE.getPurchaseListSummary", userId);
    }

	@Override
	public void insertPurchase(List<PurchaseVO> list) {
		mybatis.insert("PURCHASE.insertPurchase", list);		
	}

	@Override
	public List<PurchaseVO> getPurchaseListOne(PurchaseVO vo) {
		return mybatis.selectList("PURCHASE.getPurchaseListOne", vo);
	}

	@Override
	public void updatePaymentInfo(PurchaseVO vo) {
		mybatis.update("PURCHASE.updatePaymentInfo", vo);
	}

	@Override
	public int updateProductStock(PurchaseVO item) {
		return mybatis.update("PURCHASE.updateProductStock", item);
	}

	@Override
	public int updateOrderApproval(Map<String, Object> params) {
		return mybatis.update("PURCHASE.updateOrderApproval", params);
	}
	
	@Override
	public PurchaseVO getProduct(PurchaseVO vo) {
		return mybatis.selectOne("PURCHASE.DETAIL", vo);
	}
	
}
