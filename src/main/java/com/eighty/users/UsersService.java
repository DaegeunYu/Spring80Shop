package com.eighty.users;

import java.util.List;

public interface UsersService {
   void  insert(UsersVO vo);
   List<UsersVO> getSelect(UsersVO vo);
}
