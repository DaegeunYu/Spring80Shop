package com.eighty.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@SuppressWarnings("deprecation")
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private CustomUserDetailsService userDetailsService;
	
	@Autowired
	private CustomLoginSuccessHandler successHandler; // 로그인 성공시 처리내용
	@Autowired
	private CustomLoginFailureHandler failureHandler; // 로그인 실패시 처리내용

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
	    auth.userDetailsService(userDetailsService)
	   .passwordEncoder(passwordEncoder());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// CSRF는 일단 비활성화 (레거시에서 설정이 까다로움)
        http.csrf().disable();
        
		http.authorizeRequests()
		.antMatchers("/resources/**", "/css/**", "/js/**", "/images/**").permitAll()		
		.antMatchers(
				"/index.do", 
				"/product/**",
				"/users/login.do",
				"/users/sign_up.do",
				"/users/users_formOK.do",
				"/users/users_form.do",
				"/users/idCheck.do",
				"/users/business_users_form.do",
				"/users/businessJoin.do").permitAll() // 해당 경로를 통해서는 누구나 접근 가능
		// 권한별 접근 제어
		.antMatchers("/admin/**").hasAuthority("admin") // 관리자 전용 메뉴는 (ADMIN 권한이 있어야만 접근 가능)
		.antMatchers("/purchase/**").authenticated() // 해당 경로는 로그인 해야 이용가능!
		 // 그외 로그인 필수
		.anyRequest().authenticated()
		.and()
		.exceptionHandling()
        .accessDeniedPage("/admin/access-denied.do") 
        .and()
		// 로그인 설정
		.formLogin()
        .loginPage("/users/login.do")             // 로그인 띄울 주소
        .loginProcessingUrl("/users/loginOK.do")  // JSP <form action="..."> 에 적을 주소 (로그인 처리 가상 URL)
        .usernameParameter("user_id")             // JSP input name="user_id"
        .passwordParameter("user_pw")             // JSP input name="user_pw"
        .successHandler(successHandler) 			// 성공 시 세션담기 + 이전페이지 이동
        .failureHandler(failureHandler) 			// 실패 시 메시지 처리
        .permitAll()
        .and()
        // 로그아웃 설정
        .logout()
        .logoutUrl("/users/logout.do")            // 로그아웃 가상 주소
        .logoutSuccessUrl("/users/login.do")      // 로그아웃 후 이동할 페이지
        .invalidateHttpSession(true)              // 세션 삭제
        .deleteCookies("JSESSIONID")
		.permitAll();
		}  
	  

    @Bean
    public PasswordEncoder passwordEncoder() {       
      return new BCryptPasswordEncoder();
    }
    
}
