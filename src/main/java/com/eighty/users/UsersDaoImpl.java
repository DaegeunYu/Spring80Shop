package com.eighty.users;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UsersDaoImpl implements UsersDao {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public void insert(UsersVO vo) {
		mybatis.update("PRODUCT.INSERT", vo);
		
	}

	@Override
	public List<UsersVO> getSelect(UsersVO vo) {
		// TODO Auto-generated method stub
		return mybatis.selectList("PRODUCT.SELECT", vo);
	}
}
