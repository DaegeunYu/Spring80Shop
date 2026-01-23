package com.eighty.product;

import java.util.List;

public interface ProductDao {
   void  insert(ProductVO vo);
   List<ProductVO>  getSelect(ProductVO vo);
   
}
