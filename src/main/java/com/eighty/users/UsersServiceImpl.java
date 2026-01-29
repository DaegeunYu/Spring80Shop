package com.eighty.users;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsersServiceImpl implements UsersService {

	@Autowired
	private UsersDao  dao;
	
	@Override
	public void insert(UsersVO vo) {
		dao.insert(vo);
	}

	@Override
	public List<UsersVO> getSelect(UsersVO vo) {
		return dao.getSelect(vo);
	}

	@Override
	public UsersVO loginCheck(UsersVO vo) {
		return dao.loginCheck(vo);
	}
	
	@Override
	public int idCheck(String user_id) {
		return dao.idCheck(user_id);
	}

	@Override
	public UsersVO getSelectOne(UsersVO vo) {
		return dao.getSelectOne(vo);
	}
}
