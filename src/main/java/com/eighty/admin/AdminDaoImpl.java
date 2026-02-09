package com.eighty.admin;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eighty.product.ProductVO;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
    private SqlSessionTemplate mybatis;

    @Override
    public void insertProduct(ProductVO vo) {
    	mybatis.insert("PRODUCT.INSERT", vo);
    }

}
