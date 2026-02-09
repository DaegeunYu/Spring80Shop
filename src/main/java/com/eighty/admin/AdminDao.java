package com.eighty.admin;

import java.util.List;

import com.eighty.product.ProductVO;
import com.eighty.users.UsersVO;

public interface AdminDao {
	void insertProduct(ProductVO vo);
	List<UsersVO> getUsers();
	List<ProductVO> getProducts();
}
