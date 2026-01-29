package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eighty.purchase.PurchaseService;
import com.eighty.purchase.PurchaseVO;
import com.eighty.users.UsersService;
import com.eighty.users.UsersVO;


@RequestMapping("/purchase")
@Controller
public class PurchaseController {
	
	@Autowired
	private PurchaseService service;
	
	@Autowired
	private UsersService uservice;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	@PostConstruct  
	public void init() {
		path = servletContext.getRealPath("/resources/files/");
	}
	
	@GetMapping(value="/purchaseList.do")
	public String product_detail(Model model, PurchaseVO vo){
        model.addAttribute("purchaselist", service.getPurchaseList(vo));
		return "purchase/purchase_list";
	}
	
	@GetMapping("/purchase.do")
	public String purchaseForm(HttpSession session, Model model, String product_code) {
	    // 로그인한 사용자 확인
	    String id = (String) session.getAttribute("id");
	    // 로그인 검증
	    if (id != null) {
	        UsersVO buyer = new UsersVO();
	        buyer.setUser_id(id);
	        
	        UsersVO uvo = uservice.getSelectOne(buyer);
	        
	        model.addAttribute("users", uvo); 
	        model.addAttribute("product_code", product_code); 
	        
	        return "purchase/purchase_detail"; 
	    } else {
	        return "redirect:/users/login.do"; // 비 로그인 시 로그인페이지로 이동
	    }
	}
	
}
