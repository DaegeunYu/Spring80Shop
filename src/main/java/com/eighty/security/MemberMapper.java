package com.eighty.security;

import com.eighty.users.UsersVO;

public interface MemberMapper {
	UsersVO findByUserid(String user_id);
}
