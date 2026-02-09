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

import com.eighty.admin.AdminService;
import com.eighty.users.BusinessService;
import com.eighty.users.BusinessVO;
import com.eighty.users.UsersService;
import com.eighty.users.UsersVO;


@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	@PostConstruct  
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath("/resources/files/");
	}
	
	@GetMapping(value="/product_form.do")
	public String product_form() {
		return "shop/product_form";
	}
	
	


}
