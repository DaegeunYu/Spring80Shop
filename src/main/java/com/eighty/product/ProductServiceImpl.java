package com.eighty.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao  dao;
	
	@Override
	public void insert(ProductVO vo) {
		dao.insert(vo);
		
	}

	@Override
	public List<ProductVO> getSelect(ProductVO vo) {
		return dao.getSelect(vo);
	}
}
