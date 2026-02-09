package com.eighty.product;

import java.util.List;

import com.eighty.shop.SQL_TYPE;

public interface ProductDao {
	void insert(ProductVO vo);
	void insertOption(ProductVO vo);
	String getMaxCode(); // product_code의 최대값 조회시 사용
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
