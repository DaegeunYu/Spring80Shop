package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;


@RequestMapping("/purchase")
@Controller
public class PurchaseController {
	
	@Autowired
	private ProductService service;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	//메서드 자동 실행
	@PostConstruct  
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath("/resources/files/");
	}
	
	@GetMapping(value="/purchase.do")
	public String product_detail(Model model, ProductVO vo){
        model.addAttribute("product", service.getProduct(vo));
		return "purchase/purchase";
	}
}
