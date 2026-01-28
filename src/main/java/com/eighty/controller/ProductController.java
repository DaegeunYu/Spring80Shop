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
import com.eighty.shop.SQL_TYPE;


@RequestMapping("/product")
@Controller
public class ProductController {
	
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
	
	@GetMapping(value="/product_list.do")
	public String product_list(Model model, ProductVO vo){
		if (vo.getPage() < 1) {
			vo.setPage(1);
		}
		
		int count = service.count(vo, SQL_TYPE.TYPE);
		int currentPage = vo.getPage();
		
		int totalPage = (int) Math.ceil((double) count / vo.getAmount());
		int endPage = (int) (Math.ceil(currentPage / (double) vo.getDisplayPage()) * vo.getDisplayPage());
		int startPage = (endPage-vo.getDisplayPage()) + 1;
		
		if (totalPage < endPage) {
			endPage = totalPage;
		}
		boolean prev = startPage > 1;
		boolean next = endPage < totalPage;
		
		int start = (currentPage-1)*vo.getAmount();
		vo.setStart(start);
		
		model.addAttribute("product_list", service.getProductList(vo, SQL_TYPE.TYPE));
		model.addAttribute("start_page", startPage);
		model.addAttribute("end_page", endPage);
		model.addAttribute("current_page", currentPage);
		model.addAttribute("total_page", totalPage);
		model.addAttribute("type", "is");
		model.addAttribute("value", vo.getIs_single_origin());
		model.addAttribute("prev", prev);
		model.addAttribute("next", next);
		
		return "shop/product_list";
	}
	
	@GetMapping(value="/product_detail.do")
	public String product_detail(Model model, ProductVO vo){
        model.addAttribute("product", service.getProduct(vo));
		return "shop/product_detail";
	}
}
