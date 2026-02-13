package com.eighty.users;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UsersServiceImpl implements UsersService {

	@Autowired
	private UsersDao  dao;
	
	@Override
	public void insert(UsersVO vo) {
		dao.insert(vo);
	}
	
	@Override
	public int delete(UsersVO vo) {
		return dao.delete(vo);
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

	@Override
    @Transactional
    public int updateUserAdmin(UsersVO vo) {
		// 타입별 데이터 보정 (안전장치)
        if ("business".equals(vo.getUser_type())) {
            vo.setUser_age(null); // 법인은 나이 정보 제거
            vo.setUser_gender(null);
            vo.setRecommender_id(null);
        }

        return dao.updateUserAdmin(vo);
    }
}
