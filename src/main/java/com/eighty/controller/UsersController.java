package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eighty.users.UsersService;
import com.eighty.users.UsersVO;


@RequestMapping("/users")
@Controller
public class UsersController {
	
	@Autowired
	private UsersService service;
	
	@Autowired
    private UsersService userService;
	
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
		
	@GetMapping(value="/users_list.do")
	public String product_list(Model model, UsersVO vo){
        model.addAttribute("li", service.getSelect(vo));
		return "shop/users_list";
	}
	
	@PostMapping("/loginSuccess.do")
	public String login(UsersVO vo, HttpSession session, Model model) {
		UsersVO loginUser = userService.loginCheck(vo);
		if (loginUser != null && loginUser.getUser_pw().equals(vo.getUser_pw())) {
			session.setAttribute("id", loginUser.getUser_id());
			session.setAttribute("userName", loginUser.getUser_name());
			return "redirect:/index.do";
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다.");
			return "users/login";
		}
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {	    
	    session.invalidate();	   
	    return "redirect:/index.do";
	}
	
	@GetMapping(value="/users_form.do")
	public String users_form() {
		return "users/users_form";
	}
	
	@PostMapping(value="/users_formOK.do")
	public String users_formOK(UsersVO vo) {
		
		service.insert(vo);
		
		return "redirect:/users/users_list.do";
	}

}
