package com.eighty.admin;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.eighty.product.ProductVO;
import com.eighty.review.ReviewDTO;
import com.eighty.users.UsersVO;

public interface AdminDao {
	void insertProduct(ProductVO vo);
	List<UsersVO> getUsers(@Param("role") String role);
	List<ProductVO> getProducts(@Param("manufacturing") String manufacturing);
	List<String> getManufacturing();
	List<ReviewDTO> getReviews();
}
