package com.eighty.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		HttpSession session = request.getSession();
		String contextPath = request.getContextPath();

		// 인증된 유저 객체 꺼내기
		Object principal = authentication.getPrincipal();

		if (principal instanceof CustomUser) {
			CustomUser user = (CustomUser) principal;

			// 세션에 사용자 정보 심기 (로그인 상태 유지용)
			session.setAttribute("id", user.getUsername());
			session.setAttribute("user_role", user.getUser_role());
			session.setAttribute("user_name", user.getUser_name());

			// 로그인 시도 시 저장되었던 에러 메시지 제거
			session.removeAttribute("msg");

			// 목적지(Target URL) 설정
			String targetUrl;

			// 관리자 권한('admin') 여부 확인 (대소문자 무시)
			if ("admin".equalsIgnoreCase(user.getUser_role())) {
				// 관리자라면 관리자 메인으로 강제 이동
				targetUrl = contextPath + "/admin/manager.do";
			} else {
				// 일반 사용자라면 보던 페이지 혹은 기본 인덱스
				String prevPage = (String) session.getAttribute("prevPage");
				if (prevPage != null && !prevPage.isEmpty()) {
					targetUrl = prevPage;
					session.removeAttribute("prevPage");
				} else {
					targetUrl = contextPath + "/index.do?page=1";
				}
			}

			// 결정된 주소로 이동
			response.sendRedirect(targetUrl);
		}
	}
}
