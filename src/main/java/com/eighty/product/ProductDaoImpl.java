package com.eighty.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
			return mybatis.selectList("PRODUCT.MANUPACT", vo);
		} else {
			return mybatis.selectList("PRODUCT.IS_SINGLE", vo);
		}
	}
	
	@Override
	public int count(ProductVO vo, SQL_TYPE type) {
		// TODO Auto-generated method stub
		if (type == SQL_TYPE.MAN) {
			return mybatis.selectOne("PRODUCT.MANUPACT_COUNT", vo);
		} else {
			return mybatis.selectOne("PRODUCT.IS_SINGLE_COUNT", vo);
		}
	}
	
	@Override
	public ProductVO getProduct(ProductVO vo) {
		// TODO Auto-generated method stub
		return mybatis.selectOne("PRODUCT.DETAIL", vo);
	}
	
	@Override
	public void updateProductGrade(String productCode, String avgScore) {
		Map<String, String> map = new HashMap<String, String>();
	    map.put("productCode", productCode);
	    map.put("avgScore", avgScore);
	    mybatis.update("PRODUCT.UPDATE_PRODUCT_GRADE", map);
	}
	
	@Override
	public int getPrice(String product_code, String product_weight) {
		Map<String, Object> params = new HashMap<String, Object>();
	    params.put("product_code", product_code);
	    params.put("product_weight", product_weight);
		return mybatis.selectOne("PRODUCT.PRICE", params);
	}

	@Override
	public int selectReviewCount(String product_code) {
		return mybatis.selectOne("mapping.SELECT_REVIEW_COUNT", product_code);
	}

	
}
