package com.eighty.users;

public interface UsersDao {
   void insert(UsersVO vo);
   int delete(UsersVO vo);
   UsersVO getSelectOne(UsersVO vo);
   UsersVO loginCheck(UsersVO vo);
   
   public int idCheck(String user_id);	
   
   int updateUserAdmin(UsersVO vo);
}
