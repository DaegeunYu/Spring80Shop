package com.eighty.users;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BusinessDaoImpl implements BusinessDao {

	@Autowired
    private SqlSessionTemplate mybatis;

    @Override
    public void insertUsers(UsersVO vo) {
    	mybatis.insert("USERS.insertUsers", vo);
    }

    @Override
    public void insertBusinessDetail(BusinessVO vo) {
    	mybatis.insert("USERS.insertBusinessDetail", vo);
    }
}
