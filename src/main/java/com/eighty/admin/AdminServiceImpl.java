package com.eighty.admin;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eighty.product.ProductVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
    private AdminDao dao;

	@Override
	public void insertProduct(ProductVO vo) {
		dao.insertProduct(vo);
	}
	
}