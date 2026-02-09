package com.eighty.product;

import java.util.List;

import com.eighty.shop.SQL_TYPE;

public interface ProductDao {
	void insert(ProductVO vo);
	void insertOption(ProductVO vo);
	List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type);
	ProductVO getProduct(ProductVO vo);
	int count(ProductVO vo, SQL_TYPE type);
	void updateProductGrade(String productCode, String avgScore);
	int selectReviewCount(String productCode);
	ProductVO getProductForReview(ProductVO vo);
	int getPrice(String product_code, String product_weight);
  
   	//LIKE
	void insert(LikeProductVO vo);
	Long getLikeCount(LikeProductVO vo);
	List<ProductVO> getLikeProduct(LikeProductVO vo);
	Short select(LikeProductVO vo);
	void update(LikeProductVO vo);
}
