package com.eighty.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomLoginFailureHandler implements AuthenticationFailureHandler{

	@Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        
		// 보안을 위해 모든 실패 원인을 하나의 친절하고 모호한 메시지로 통합합니다.
        String errorMsg = "로그인 정보가 일치하지 않습니다. \\n입력하신 회원유형/ID/PW를 다시 확인해 주시기 바랍니다.";
        
        // 로그에는 상세 원인을 남겨서 개발자만 볼 수 있게 합니다.
        System.out.println("로그인 실패 원인: " + exception.getMessage());

        request.getSession().setAttribute("msg", errorMsg);
        response.sendRedirect(request.getContextPath() + "/users/login.do?error=true");
    }
}
