package com.eighty.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public void insert(ProductVO vo) {
		mybatis.update("PRODUCT.INSERT", vo);
		
	}

	@Override
	public List<ProductVO> getSelect(ProductVO vo) {
		// TODO Auto-generated method stub
		return mybatis.selectList("PRODUCT.SELECT");
	}
}
