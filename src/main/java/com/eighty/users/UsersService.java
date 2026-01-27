package com.eighty.users;

import java.util.List;

public interface UsersService {
   void  insert(UsersVO vo);
   List<UsersVO> getSelect(UsersVO vo);
   UsersVO loginCheck(UsersVO vo);
   
   public int idCheck(String user_id);
}
