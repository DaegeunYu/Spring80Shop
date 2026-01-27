package com.eighty.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
import com.eighty.shop.SQL_TYPE;


@Controller
public class StartController {
	
	@Autowired
	private ProductService service;
	
	StartController(){
		System.out.println("==> StartController");
	}
	
	@GetMapping(value="/index.do")
	public String index(Model model, ProductVO vo) {
		vo.setManufacturing("(주)80s");
		model.addAttribute("product_list", service.getProductList(vo, SQL_TYPE.MAN));
		return "index";
	}
}
