package com.eighty.users;

public interface UsersService {
   void insert(UsersVO vo);
   int delete(UsersVO vo);
   UsersVO getSelectOne(UsersVO vo);
   UsersVO loginCheck(UsersVO vo);
   
   public int idCheck(String user_id);
   
   int updateUserAdmin(UsersVO vo);
   
   // 시큐리티 로그인용 회원 조회
   UsersVO selectUserForLogin(String user_id, String user_type);
}
