package com.eighty.users;

import java.util.HashMap;
import java.util.Map;

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
	public int delete(UsersVO vo) {
		return mybatis.delete("USERS.DELETE", vo);
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
	
	@Override
	public int updateUserAdmin(UsersVO vo) {
		return mybatis.update("USERS.UPDATE", vo);
	}
	
	// 시큐리티 전용
	@Override
	public UsersVO selectUserForLogin(String user_id, String user_type) {
		Map<String, String> param = new HashMap<String, String>();
        param.put("user_id", user_id);
        param.put("user_type", user_type);
		return mybatis.selectOne("USERS.selectUserForLogin", param);
	}
}
