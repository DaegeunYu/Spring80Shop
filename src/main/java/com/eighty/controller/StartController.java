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
		
		int count = service.count(vo, SQL_TYPE.MAN);
		int currentPage = vo.getPage();
		int displayPage = 6;
		
		int totalPage = (int) Math.ceil((double) count / vo.getAmount());
		int endPage = (int) (Math.ceil(currentPage / (double) displayPage) * displayPage);
		int startPage = (endPage-displayPage) + 1;
		
		if (totalPage < endPage) {
			endPage = totalPage;
		}
		boolean prev = startPage > 1;
		boolean next = endPage < totalPage;
		
		int start = (currentPage-1)*vo.getAmount();
		vo.setStart(start);
		vo.setEnd(start + vo.getAmount());
		
		model.addAttribute("product_list", service.getProductList(vo, SQL_TYPE.MAN));
		model.addAttribute("start_page", startPage);
		model.addAttribute("end_page", endPage);
		model.addAttribute("current_page", currentPage);
		model.addAttribute("total_page", totalPage);
		model.addAttribute("prev", prev);
		model.addAttribute("next", next);
		
		return "index";
	}
}
