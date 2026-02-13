package com.eighty.users;

import java.util.List;

public interface UsersService {
   void insert(UsersVO vo);
   int delete(UsersVO vo);
   UsersVO getSelectOne(UsersVO vo);
   UsersVO loginCheck(UsersVO vo);
   
   public int idCheck(String user_id);
}
