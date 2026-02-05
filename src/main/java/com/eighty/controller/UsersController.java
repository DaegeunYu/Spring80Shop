package com.eighty.controller;

import java.io.File;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eighty.users.BusinessService;
import com.eighty.users.BusinessVO;
import com.eighty.users.UsersService;
import com.eighty.users.UsersVO;


@RequestMapping("/users")
@Controller
public class UsersController {
	
	@Autowired
	private UsersService service;
	
	@Autowired
    private BusinessService businessService;
	
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
	public String login(HttpSession session, HttpServletRequest request) {
		// 이전 페이지 주소를 가져옴
	    String referer = request.getHeader("Referer");
	    
	    // 이전 페이지가 있고, 로그인 페이지 자체가 아니라면 세션에 저장
	    if (referer != null && !referer.contains("/login.do")) {
	        session.setAttribute("prevPage", referer);
	    }
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
	public String loginSuccess(UsersVO vo, String userType, HttpSession session, Model model) {
	    UsersVO loginUser = service.loginCheck(vo);

	    // 1. 유저 존재 및 비밀번호 검증
	    if (loginUser == null || !passwordEncoder.matches(vo.getUser_pw(), loginUser.getUser_pw())) {
	        model.addAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다.");
	        return "users/login";
	    }

	    // 2. 선택한 유형과 실제 권한 비교
	    if (userType.equals(loginUser.getUser_role())) {
	        session.setAttribute("id", loginUser.getUser_id());
	        session.setAttribute("userName", loginUser.getUser_name());
	        session.setAttribute("userRole", loginUser.getUser_role());

	        // [복구 부분] 이전 페이지 정보가 있다면 해당 페이지로 이동
	        String prevPage = (String) session.getAttribute("prevPage");
	        if (prevPage != null && !prevPage.isEmpty()) {
	            session.removeAttribute("prevPage");
	            return "redirect:" + prevPage;
	        }

	        return "redirect:/index.do?page=1";
	    } else {
	        model.addAttribute("msg", "회원 유형 선택이 올바르지 않습니다.");
	        return "users/login";
	    }
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {	    
	    session.invalidate();	   
	    return "redirect:/index.do?page=1";
	}
	
	@GetMapping(value="/sign_up.do")
	public String sign_up() {
		return "users/users_signup_select";
	}
	
	@GetMapping(value="/users_form.do")
	public String users_form() {
		return "users/users_form";
	}
	
	@GetMapping(value="/business_users_form.do")
	public String business_users_form() {
		return "users/business_users_form";
	}
	
	@PostMapping(value="/users_formOK.do")
	public String users_formOK(UsersVO vo, Model model, HttpSession session, RedirectAttributes joinRedirect) {
		
		
		// 비밀번호 암호화 설정
	    String encodePw = passwordEncoder.encode(vo.getUser_pw());
	    vo.setUser_pw(encodePw);
		
	    
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
	    
	
	    
	    vo.setUser_role("member"); // 회원가입 시 기본 member로 권한 설정

	    service.insert(vo);
	    
	    	// 가입 성공 직후 즉시 로그인
	 		session.setAttribute("id", vo.getUser_id());
	 		session.setAttribute("userName", vo.getUser_name());
	 		
	 		joinRedirect.addFlashAttribute("msg", vo.getUser_name() + "님, 회원가입을 축하합니다!");
		
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
	
	@PostMapping("/businessJoin.do")
	public String businessJoin(UsersVO uVo, BusinessVO bVo, 
	                           @RequestParam("file") MultipartFile file, 
	                           Model model, HttpSession session, RedirectAttributes joinRedirect) {
	    try {
	        // 1. 비밀번호 암호화 (BCrypt)
	        uVo.setUser_pw(passwordEncoder.encode(uVo.getUser_pw()));

	        // 2. 사업자 등록증 파일 업로드 처리
	        if (file != null && !file.isEmpty()) {
	            // init()에서 만들어둔 path 사용 (resources/files/)
	            File folder = new File(path);
	            if (!folder.exists()) folder.mkdirs();

	            // 파일명 중복 방지를 위해 밀리초 추가
	            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	            file.transferTo(new File(path + fileName));
	            
	            // BusinessVO(카멜표기법)에 파일명 세팅
	            bVo.setBizLicenseFile(fileName); 
	        }

	        // 3. 서비스 호출 (Users + Business 한 번에 처리)
	        businessService.joinBusiness(uVo, bVo);

	        // 4. 가입 성공 후 즉시 로그인 세션 생성
	        session.setAttribute("id", uVo.getUser_id());
	        session.setAttribute("userName", bVo.getCompanyName()); // 법인은 상호명을 이름으로
	        session.setAttribute("userRole", "business");

	        joinRedirect.addFlashAttribute("msg", bVo.getCompanyName() + "님, 법인 가입을 축하합니다!");
	        return "redirect:/index.do?page=1";

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("msg", "법인 가입 처리 중 오류가 발생했습니다.");
	        return "users/business_users_form";
	    }
	}


}
