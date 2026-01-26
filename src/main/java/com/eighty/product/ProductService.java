package com.eighty.product;

import java.util.List;

public interface ProductService {
   void  insert(ProductVO vo);
   List<ProductVO> getProductList(ProductVO vo);
   ProductVO getProduct(ProductVO vo);
}
