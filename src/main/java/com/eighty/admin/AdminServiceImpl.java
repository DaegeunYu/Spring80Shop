package com.eighty.admin;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eighty.product.ProductVO;
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
	public List<UsersVO> getUsers() {
		return dao.getUsers();
	}
	
	@Override
	public List<ProductVO> getProducts() {
		return dao.getProducts();
	}
	
}