package com.eighty.purchase;

import java.util.List;

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
	public void insertPurchase(List<PurchaseVO> list) {
		mybatis.insert("PURCHASE.insertPurchase", list);		
	}

	@Override
	public PurchaseVO getPurchaseListOne(PurchaseVO vo) {
		return mybatis.selectOne("PURCHASE.getPurchaseListOne", vo);
	}
}
