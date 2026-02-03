package com.eighty.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eighty.shop.SQL_TYPE;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao  dao;
	
	@Override
	public void insert(ProductVO vo) {
		dao.insert(vo);
	}

	@Override
	public List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type) {
		return dao.getProductList(vo, type);
	}

	@Override
	public ProductVO getProduct(ProductVO vo) {
		return dao.getProduct(vo);
	}

	@Override
	public int count(ProductVO vo, SQL_TYPE type) {
		return dao.count(vo, type);
	}

	@Override
	public ProductVO getProductDetail(String productCode) {
		ProductVO vo = new ProductVO();
	    vo.setProduct_code(productCode);
	    return dao.getProduct(vo);
	}
	
	@Override
	public int getPrice(String product_code, String product_weight) {
		return dao.getPrice(product_code, product_weight);
	}

	
	// LIKE
	@Override
	public void insert(LikeProductVO vo) {
		dao.insert(vo);
	}
	
	@Override
	public Long getLikeCount(LikeProductVO vo) {
		return dao.getLikeCount(vo);
	}

	@Override
	public List<ProductVO> getLikeProduct(LikeProductVO vo) {
		return dao.getLikeProduct(vo);
	}

	@Override
	public Short select(LikeProductVO vo) {
		return dao.select(vo);
	}

	@Override
	public void update(LikeProductVO vo) {
		dao.update(vo);
	}
}
