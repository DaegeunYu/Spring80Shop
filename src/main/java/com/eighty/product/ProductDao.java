package com.eighty.product;

import java.util.List;

import com.eighty.shop.SQL_TYPE;

public interface ProductDao {
   void insert(ProductVO vo);
   List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type);
   ProductVO getProduct(ProductVO vo);
   int count(ProductVO vo, SQL_TYPE type);
   void updateProductGrade(String productCode, String avgScore);
   int selectReviewCount(String productCode);
   
   int getPrice(String product_code, String product_weight);
}
