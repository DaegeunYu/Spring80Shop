package com.eighty.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.eighty.shop.SQL_TYPE;

public interface ProductDao {
	void insert(ProductVO vo);
	void insertOption(ProductVO.ProductOption vo);
	String getMaxCode(); // product_code의 최대값 조회시 사용
	List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type);
	ProductVO getProduct(ProductVO vo);
	int count(ProductVO vo, SQL_TYPE type);
	void updateProductGrade(String productCode, String avgScore);
	int selectReviewCount(String productCode);
	ProductVO getProductForReview(ProductVO vo);
	int getPrice(String product_code, String product_weight);
	int delProduct(@Param("idx") int idx);
  
   	//LIKE
	void insert(LikeProductVO vo);
	Long getLikeCount(LikeProductVO vo);
	List<ProductVO> getLikeProduct(LikeProductVO vo);
	Short select(LikeProductVO vo);
	void update(LikeProductVO vo);
}
