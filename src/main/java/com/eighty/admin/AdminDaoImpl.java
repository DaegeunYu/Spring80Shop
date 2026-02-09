package com.eighty.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eighty.product.ProductVO;
import com.eighty.shop.SQL_TYPE;
import com.eighty.users.UsersVO;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
    private SqlSessionTemplate mybatis;

    @Override
    public void insertProduct(ProductVO vo) {
    	mybatis.insert("PRODUCT.INSERT", vo);
    }
    
    @Override
	public List<UsersVO> getUsers() {
		return mybatis.selectList("USERS.SELECT");
	}
    
    @Override
	public List<ProductVO> getProducts() {
		return mybatis.selectList("PRODUCT.SELECT");
	}

}
