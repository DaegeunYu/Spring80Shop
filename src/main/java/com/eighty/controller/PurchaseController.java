package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
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
	private ProductService proservice;
	
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
	public String purchaseForm(HttpSession session, Model model, 
							   String product_code, String product_count) {
	    // 로그인한 사용자 확인
	    String id = (String) session.getAttribute("id");
	    // 로그인 검증
	    if (id != null) {
	        UsersVO buyer = new UsersVO();
	        buyer.setUser_id(id);//유저 조회 대상 지정
	        model.addAttribute("users", uservice.getSelectOne(buyer)); //DB에서 회원 정보 조회 후 객체를 model에 저장
	        
	        ProductVO pvo = new ProductVO();
	        pvo.setProduct_code(product_code); //제품 조회 대상 지정
	        
	        model.addAttribute("product", proservice.getProduct(pvo));//DB에서 상품 정보 조회 후 객체를 model에 저장
	        	        
	        model.addAttribute("product_count", product_count);//제품 선택 수량
	        
	        return "purchase/purchase_detail"; 
	    } else {
	        return "redirect:/users/login.do"; // 비 로그인 시 로그인페이지로 이동
	    }
	}
	
}
