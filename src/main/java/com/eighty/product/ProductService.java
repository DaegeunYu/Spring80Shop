package com.eighty.product;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.eighty.shop.SQL_TYPE;

public interface ProductService {

	void insert(ProductVO vo, MultipartFile file);
	List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type);
	ProductVO getProduct(ProductVO vo);
	int count(ProductVO vo, SQL_TYPE type);
	ProductVO getProductDetail(String productCode);
	int getPrice(String product_code, String product_weight);
   
	// LIKE
	void insert(LikeProductVO vo);
	Long getLikeCount(LikeProductVO vo);
	List<ProductVO> getLikeProduct(LikeProductVO vo);
	Short select(LikeProductVO vo);
	void update(LikeProductVO vo);
}
