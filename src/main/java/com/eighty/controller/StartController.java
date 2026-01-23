package com.eighty.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StartController {
	StartController(){
		System.out.println("==> StartController");
	}
	
	@GetMapping(value="/index.do")
	public String index(HttpServletRequest request, HttpSession sesstion) {
		return "index";
	}
}
