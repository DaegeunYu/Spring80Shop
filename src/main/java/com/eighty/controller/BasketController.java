package com.eighty.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eighty.basket.BasketService;
import com.eighty.basket.BasketVO;
import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
import com.eighty.shop.ParameterValue;


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
		path = servletContext.getRealPath(new ParameterValue().getFilePath());
	}
	
	@GetMapping(value="/basket_in.do")
	public String basket_in(HttpSession session, Model model, BasketVO vo) {
		String id = (String) session.getAttribute("id");
		ProductVO pVo = new ProductVO();
		
		pVo.setProduct_code(vo.getProduct_code());
		pVo = pService.getProduct(pVo);
		int price = pService.getPrice(vo.getProduct_code(), vo.getProduct_weight());
		
		vo.setUser_id(id);
		vo.setProduct_name(pVo.getProduct_name());
		vo.setProduct_img(pVo.getProduct_img());
		vo.setBasket_price(String.valueOf(price));
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
	
	@RequestMapping("/basket_delete.do")
    public ResponseEntity<String> deleteItems(@RequestBody List<BasketVO> voList) {
		service.delete(voList);
        return ResponseEntity.ok("삭제 성공");
    }
}
