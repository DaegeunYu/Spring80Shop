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
		mybatis.update("USERS.INSERT", vo);
	}

	@Override
	public UsersVO loginCheck(UsersVO vo) {
		return mybatis.selectOne("USERS.getUserById", vo);
	}
	
	@Override
	public int idCheck(String user_id) {
		return mybatis.selectOne("USERS.idCheck", user_id);
	}

	@Override
	public UsersVO getSelectOne(UsersVO vo) {
		return mybatis.selectOne("USERS.getSelectOne", vo);
	}
}
