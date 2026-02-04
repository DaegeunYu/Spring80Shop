package com.eighty.users;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BusinessServiceImpl implements BusinessService {
	@Autowired
    private BusinessDao businessDao;

	@Transactional
	@Override
	public void joinBusiness(UsersVO uVo, BusinessVO bVo) {
	    // 1. 상호명 복사 (uVo의 user_name을 채우기 위해)
	    uVo.setUser_name(bVo.getCompanyName());
	    uVo.setUser_role("business");
	    
	    // 2. 부모 테이블(users) 먼저 저장
	    businessDao.insertUsers(uVo); 
	    
	    // 3. [핵심] uVo에 담긴 ID를 bVo의 businessId로 복사!!
	    // 이렇게 해야 business_users 테이블에 ID가 들어갑니다.
	    bVo.setBusinessId(uVo.getUser_id()); 
	    
	    // 4. 자식 테이블(business_users) 저장
	    businessDao.insertBusinessDetail(bVo);
	}
}