package com.eighty.purchase;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eighty.product.ProductDao;

@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	private PurchaseDao  dao;

	@Override
	public List<PurchaseVO> getPurchaseList(PurchaseVO vo) {
		return dao.getPurchaseList(vo);
	}
}
