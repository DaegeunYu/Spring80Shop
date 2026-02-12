package com.eighty.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.eighty.shop.SQL_TYPE;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	@Transactional
	public void insert(ProductVO vo) {
		mybatis.insert("PRODUCT.INSERT_PRODUCT", vo);
	}
	
	@Override
	@Transactional
	public void update(ProductVO vo) {
		mybatis.update("PRODUCT.UPDATE_PRODUCT", vo);
	}
	
	@Override
    public void insertOption(ProductVO.ProductOption vo) {
        mybatis.insert("PRODUCT.INSERT_PRODUCT_OPTION", vo);
    }
	
	@Override
    public int deleteOption(String product_code) {
        return mybatis.delete("PRODUCT.DELETE_PRODUCT_OPTION", product_code);
    }
	
	@Override
    public List<ProductVO.ProductOption> getProductOption(String product_code) {
        return mybatis.selectList("PRODUCT.OPTION", product_code);
    }

	@Override
	public List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type) {
		if (type == SQL_TYPE.MAN) {
			return mybatis.selectList("PRODUCT.MANUPACT", vo);
		} else {
			return mybatis.selectList("PRODUCT.IS_SINGLE", vo);
		}
	}
	
	@Override
	public int count(ProductVO vo, SQL_TYPE type) {
		if (type == SQL_TYPE.MAN) {
			return mybatis.selectOne("PRODUCT.MANUPACT_COUNT", vo);
		} else {
			return mybatis.selectOne("PRODUCT.IS_SINGLE_COUNT", vo);
		}
	}
	
	@Override
	public ProductVO getProduct(ProductVO vo) {
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

	@Override
	public ProductVO getProductForReview(ProductVO vo) {
		return mybatis.selectOne("PRODUCT.getProductForReview", vo);
	}
	
	@Override
	public int delProduct(@Param("idx") int idx) {
		return mybatis.delete("PRODUCT.DELETE", idx);
	}
	
	@Override
	public int delProductRecently(@Param("product_code") String product_code) {
		return mybatis.delete("PRODUCT.DELETE_RECENTLY", product_code);
	}

	
	// LIKE
	@Override
	public void insert(LikeProductVO vo) {
		mybatis.insert("PRODUCT.INSERT_LIKE", vo);
	}
	
	@Override
	public Long getLikeCount(LikeProductVO vo) {
		return mybatis.selectOne("PRODUCT.SELECT_LIKE_COUNT", vo);
	}
	
	@Override
	public List<ProductVO> getLikeProduct(LikeProductVO vo) {
		return mybatis.selectList("PRODUCT.SELECT_LIKE_LIST", vo);
	}

	@Override
	public Short select(LikeProductVO vo) {
		return mybatis.selectOne("PRODUCT.SELECT_LIKE", vo);
	}

	@Override
	public void update(LikeProductVO vo) {
		mybatis.update("PRODUCT.UPDATE_LIKE", vo);
	}

	@Override
	public String getMaxCode() {
		return mybatis.selectOne("PRODUCT.GET_MAX_CODE");
	}
}
