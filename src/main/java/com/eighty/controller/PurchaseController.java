package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eighty.purchase.PurchaseService;
import com.eighty.purchase.PurchaseVO;


@RequestMapping("/purchase")
@Controller
public class PurchaseController {
	
	@Autowired
	private PurchaseService service;
	
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
}
