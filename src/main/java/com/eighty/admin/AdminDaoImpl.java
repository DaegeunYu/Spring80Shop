package com.eighty.admin;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eighty.product.ProductVO;
import com.eighty.review.ReviewDTO;
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
	public List<UsersVO> getUsers(@Param("role") String role) {
		return mybatis.selectList("USERS.SELECT", role);
	}
    
    @Override
	public List<ProductVO> getProducts(@Param("manufacturing") String manufacturing) {
		return mybatis.selectList("PRODUCT.SELECT", manufacturing);
	}
    
    @Override
	public List<String> getManufacturing() {
		return mybatis.selectList("PRODUCT.MAN");
	}
    
    @Override
	public List<ReviewDTO> getReviews() {
		return mybatis.selectList("REVIEW.SELECT");
	}

}
