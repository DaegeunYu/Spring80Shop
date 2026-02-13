package com.eighty.users;

import java.util.List;

public interface UsersDao {
   void  insert(UsersVO vo);
   UsersVO getSelectOne(UsersVO vo);
   UsersVO loginCheck(UsersVO vo);
   
   public int idCheck(String user_id);	
   
   int updateUserAdmin(UsersVO vo);
}
