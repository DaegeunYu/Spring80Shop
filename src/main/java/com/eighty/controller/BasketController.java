package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eighty.basket.BasketService;
import com.eighty.basket.BasketVO;
import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;


@RequestMapping("/basket")
@Controller
public class BasketController {
	
	@Autowired
	private BasketService service;
	
	@Autowired
	private ProductService pService;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	//메서드 자동 실행
	@PostConstruct  
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath("/resources/files/");
	}
	
	@GetMapping(value="/basket_in.do")
	public String basket_in(HttpSession session, Model model, BasketVO vo) {
		String id = (String) session.getAttribute("id");
		ProductVO pVo = new ProductVO();
		pVo.setProduct_code(vo.getProduct_code());
		pVo = pService.getProduct(pVo);
		
		vo.setUser_id(id);
		vo.setProduct_name(pVo.getProduct_name());
		vo.setProduct_img(pVo.getProduct_img());
		service.insert(vo);
		
		model.addAttribute("basket_list", service.getProductList(vo));
		return "basket/basket_list";
	}
	
	@GetMapping(value="/basket_list.do")
	public String basket_list(HttpSession session, Model model, BasketVO vo){
		String id = (String) session.getAttribute("id");
		vo.setUser_id(id);
		model.addAttribute("basket_list", service.getProductList(vo));
		return "basket/basket_list";
	}
	
	@GetMapping(value="/basket_delete.do")
	public String basket_delete(HttpSession session, Model model, BasketVO vo){
		String id = (String) session.getAttribute("id");
		vo.setUser_id(id);
		
		return "basket/basket_list";
	}
	
	@RequestMapping("/basket_delete.do")
	@ResponseBody // AJAX 응답을 위해 필요
	public String basket_delete(@RequestParam("product_code") String productCodes, HttpSession session) {
		BasketVO vo = new BasketVO();
		String id = (String) session.getAttribute("id");
		vo.setUser_id(id);
		try {
	        // 1,2,3 형태의 문자열을 배열로 분리
	        String[] codes = productCodes.split(",");
	        
	        for(String code : codes) {
	        	vo.setProduct_code(code);
	        	service.delete(vo);
	        }
	        
	        return "success";
	    } catch (Exception e) {
	        return "fail";
	    }
	}
}
