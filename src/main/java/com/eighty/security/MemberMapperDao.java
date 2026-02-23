package com.eighty.security;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eighty.users.UsersVO;

@Repository
public class MemberMapperDao implements MemberMapper {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public UsersVO findByUserid(String user_id) {
		return mybatis.selectOne("USERS.getSelectOne", user_id);
	}

}
