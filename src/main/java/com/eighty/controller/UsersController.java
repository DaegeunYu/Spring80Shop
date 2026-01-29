package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eighty.users.UsersService;
import com.eighty.users.UsersVO;


@RequestMapping("/users")
@Controller
public class UsersController {
	
	@Autowired
	private UsersService service;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	//메서드 자동 실행
	@PostConstruct  
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath("/resources/files/");
	}
	
	@GetMapping(value="/login.do")
	public String login() {
		return "users/login";		
	}
	
	/*  PJ TODO : 회원 리스트 만들어야 함 
	@GetMapping(value="/users_list.do")
	public String product_list(Model model, UsersVO vo){
        model.addAttribute("li", service.getSelect(vo));
		return "shop/users_list";
	}
	*/
	
	@PostMapping("/loginSuccess.do")
	public String login(UsersVO vo, HttpSession session, Model model) {
		UsersVO loginUser = service.loginCheck(vo);
		if (loginUser != null && passwordEncoder.matches(vo.getUser_pw(), loginUser.getUser_pw())) {
			session.setAttribute("id", loginUser.getUser_id());
			session.setAttribute("userName", loginUser.getUser_name());
			return "redirect:/index.do?page=1";
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다.");
			return "users/login";
		}
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {	    
	    session.invalidate();	   
	    return "redirect:/index.do?page=1";
	}
	
	@GetMapping(value="/users_form.do")
	public String users_form() {
		return "users/users_form";
	}
	
	@PostMapping(value="/users_formOK.do")
	public String users_formOK(UsersVO vo, Model model, HttpSession session, RedirectAttributes rttr) {
		
		
		// 비밀번호 암호화 설정
	    String encodePw = passwordEncoder.encode(vo.getUser_pw());
	    vo.setUser_pw(encodePw);
		
	    /*  PJ TODO : 테스트 완료 후 주석 삭제 =============
		 // 아이디 중복 검사
	    int id = service.idCheck(vo.getUser_id());

	    if (id > 0) {
	        model.addAttribute("msg", "이미 사용 중인 아이디입니다.");
	        return "users/users_form"; // 다시 가입 페이지
	    }
		
	   	// 생일 입력 시 나이 계산 후 DB에 입력 
		String birth = vo.getUser_birthday(); 
	    if (birth != null && birth.length() == 8) {
	        // 나이 계산 (현재 연도 - 태어난 연도 )
	        int birthYear = Integer.parseInt(birth.substring(0, 4));
	        int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
	        int age = currentYear - birthYear;
	        System.out.println("====== 나이계산 ======");
	        // VO에 계산된 나이 설정 (사용자 입력값 덮어쓰기)
	        vo.setUser_age(age);
	        // 생일 날짜 포맷팅 (YYYY-MM-DD)
	        String formattedBirth = birth.substring(0, 4) + "-" + 
	                                birth.substring(4, 6) + "-" + 
	                                birth.substring(6, 8);
	        vo.setUser_birthday(formattedBirth);
	    }
	    System.out.println("VO 내 나이값: " + vo.getUser_age()); 
	    
	    ====================테스트 완료 후 주석 삭제 */
	    
	    vo.setUser_role("member"); // 회원가입 시 기본 member로 권한 설정

	    service.insert(vo);
	    
	    	// 가입 성공 직후 즉시 로그인
	 		session.setAttribute("id", vo.getUser_id());
	 		session.setAttribute("userName", vo.getUser_name());
	 		
	 		rttr.addFlashAttribute("msg", vo.getUser_name() + "님, 회원가입을 축하합니다!");
		
		return "redirect:/index.do?page=1";
	}
	
	@ResponseBody
	@GetMapping(value = "/idCheck.do")
	String nameCheck(UsersVO vo) {
		System.out.println("아이디확인(1):" + vo.getUser_id());
		// DB에 id 존재 유무만 판단, 0=>중복값 없음 1=>중복값 존재
		int id = service.idCheck(vo.getUser_id());
		System.out.println("아이디확인(2):" + id);
		if (id > 0) {
			return "T"; // 중복값이 있다.
		}else {
			return "F"; // 중복값이 없다.
		}		
	}	

}
