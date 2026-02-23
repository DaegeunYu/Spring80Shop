package com.eighty.users;

public interface UsersDao {
   void insert(UsersVO vo);
   int delete(UsersVO vo);
   UsersVO getSelectOne(UsersVO vo);
   UsersVO loginCheck(UsersVO vo);
   
   public int idCheck(String user_id);	
   
   int updateUserAdmin(UsersVO vo);
   
   // 시큐리티에서 사용자 정보 조회용
   UsersVO selectUserForLogin(String user_id, String user_type);
}
