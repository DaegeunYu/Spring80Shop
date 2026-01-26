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
	public List<ProductVO> getProductList(ProductVO vo) {
		// TODO Auto-generated method stub
		return mybatis.selectList("PRODUCT.SELECT_PRODUCTS", vo);
	}
	
	@Override
	public ProductVO getProduct(ProductVO vo) {
		// TODO Auto-generated method stub
		return mybatis.selectOne("PRODUCT.SELECT_PRODUCT", vo);
	}
}
