package com.eighty.security;

import java.util.Collection;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {
	
	// 1. 고유 식별 번호 추가 (노란 줄 해결 및 세션 안정성 확보)
	private static final long serialVersionUID = 1L;
	
	private String user_type; // 일반/기업 구분용
	private String user_name;
	private String user_role;
	
	public CustomUser(String username, String password, 
					Collection<? extends GrantedAuthority> authorities, 
					String user_type, String user_name, String user_role) {
		super(username, password, authorities);
		this.user_type = user_type;
		this.user_name = user_name;
		this.user_role = user_role;
	}
		
	public String getUser_type() {
		return user_type;
	}
	
	public String getUser_name() {
		return user_name;
	}
	
	public String getUser_role() {
		return user_role;
	}

}
