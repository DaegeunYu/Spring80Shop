package com.eighty.users;

import lombok.Data;

@Data
public class UsersVO {
	private int idx;
	private String user_id; // 유저 & 법인 ID
	private String user_pw; // 유저 & 법인 비밀번호
	private String user_name; // 이름 & 법인 상호명
	private Integer user_age; // 나이 & 법인은 입력안함
	private String user_birthday; // 생일 & 법인은 입력안함
	private String user_tel; // 전화번호 & 회사연락처
	private String user_email; // 이메일 & 회사이메일
	private String user_add; // 주소 & 법인 사업장주소
	private String user_role; // 등급 (일반 : member / 법인 : business)
	private String user_gender; // 성별 & 법인은 입력안함
	private String recommender_id; // 추천자 ID & 법인은 입력안함
	
	private String join_date; // 가입일
	private String login_date; // 최근 로그인
}
