package com.eighty.product;

import java.util.List;

import com.eighty.shop.SQL_TYPE;

public interface ProductService {
   void insert(ProductVO vo);
   List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type);
   ProductVO getProduct(ProductVO vo);
   int count(ProductVO vo, SQL_TYPE type);
   
   int getPrice(String product_code, String product_weight);
}
