package com.eighty.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eighty.shop.SQL_TYPE;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public void insert(ProductVO vo) {
		mybatis.update("PRODUCT.INSERT", vo);
		
	}

	@Override
	public List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type) {
		// TODO Auto-generated method stub
		if (type == SQL_TYPE.MAN) {
			return mybatis.selectList("PRODUCT.SELECT_PRODUCTS_ITS", vo);
		} else {
			return mybatis.selectList("PRODUCT.SELECT_PRODUCTS", vo);
		}
	}
	
	@Override
	public ProductVO getProduct(ProductVO vo) {
		// TODO Auto-generated method stub
		return mybatis.selectOne("PRODUCT.SELECT_PRODUCT", vo);
	}
}
