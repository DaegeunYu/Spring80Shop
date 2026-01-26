package com.eighty.users;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class UsersVO {
	private int idx;
	private String user_id; // 유저 ID
	private String user_pw; // 유저 비밀번호
	private String user_name; // 이름
	private String user_age; // 나이
	private String user_birthday; // 생일
	private String user_tel; // 전화번호
	private String user_email; // 이메일
	private String user_add; // 주소
	private String user_role; // 등급
	private String user_gender; // 성별
	private String recommender_id; // 추천자 ID
	
	private String join_date; // 가입일
	private String login_date; // 최근 로그인
}
