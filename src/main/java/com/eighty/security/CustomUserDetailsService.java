package com.eighty.security;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.eighty.users.UsersService;
import com.eighty.users.UsersVO;

@Service("customUserDetailsService")
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
    private UsersService usersService;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		String user_type = null;
		
		// [2안의 핵심] 에러가 발생해도 죽지 않게 보호막을 칩니다.
		try {
			ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
			if (sra != null) {
				HttpServletRequest request = sra.getRequest();
				user_type = request.getParameter("user_type");
			}
		} catch (Exception e) {
			// 아직 RequestContext가 생성되지 않았을 때 이곳으로 들어옵니다.
			System.out.println("보안 필터 단계에서 Request 정보를 즉시 가져올 수 없습니다. (Listener 미등록 가능성)");
		}
		
		// user_type이 null이라면 기본값으로 보정 (테스트용)
		if (user_type == null) {
			user_type = "personal"; 
		}

		// 이제 에러 없이 이 출력문들이 콘솔에 찍힐 겁니다!
		System.out.println("========================================");
		System.out.println("보안 인증 시작 - ID: " + username);
		System.out.println("보안 인증 시작 - Type: " + user_type);
		System.out.println("========================================");
		
        UsersVO vo = usersService.selectUserForLogin(username, user_type);
        
        if (vo == null) {
            System.err.println("[보안 로그] 미존재 아이디 접근 시도: " + username);
            throw new UsernameNotFoundException("유저 없음");
        }

        if (!vo.getUser_type().equals(user_type)) {
            System.err.println("[보안 로그] 유형 불일치: ID(" + username + "), 선택타입(" + user_type + "), 실제타입(" + vo.getUser_type() + ")");
            throw new InternalAuthenticationServiceException("유형 불일치");
        }
		
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority(vo.getUser_role()));

        return new CustomUser(
			vo.getUser_id(), 
			vo.getUser_pw(), 
			authorities, 
			vo.getUser_type(), 
			vo.getUser_name(),
			vo.getUser_role()
        );
    }
}