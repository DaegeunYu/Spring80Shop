package com.eighty.admin;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eighty.product.ProductVO;
import com.eighty.review.ReviewDTO;
import com.eighty.users.UsersVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
    private AdminDao dao;

	@Override
	public void insertProduct(ProductVO vo) {
		dao.insertProduct(vo);
	}
	
	@Override
	public List<UsersVO> getUsers(@Param("role") String role) {
		return dao.getUsers(role);
	}
	
	@Override
	public List<ProductVO> getProducts(@Param("manufacturing") String manufacturing) {
		return dao.getProducts(manufacturing);
	}
	
	@Override
	public List<String> getManufacturing() {
		return dao.getManufacturing();
	}
	
	@Override
	public List<ReviewDTO> getReviews() {
		return dao.getReviews();
	}
	
	@Override
	public List<Map<String, Object>> getProductStats() {
		return dao.getProductStats();
	}

	@Override
	public Map<String, Object> getOverallSummary() {
		return dao.getOverallSummary();
	}

	@Override
	public List<Map<String, Object>> getProductWeightDistribution() {
		return dao.getProductWeightDistribution();
	}

	
}