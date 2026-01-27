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
import com.eighty.review.ReviewService;
import com.eighty.review.ReviewVO;


@RequestMapping("/review")
@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	//메서드 자동 실행
	@PostConstruct  
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath("/resources/files/");
	}
		
	@GetMapping(value="/review_list.do")
	public String review_list(Model model, ReviewVO vo) {
	    // 1. 파라미터가 잘 들어오는지 콘솔에서 꼭 확인해보세요!
	    System.out.println("===> 상세페이지에서 넘어온 상품코드: " + vo.getProduct_code());

	    // 2. 모델 이름을 반드시 review_list(언더바)로 지정!
	    model.addAttribute("review_list", service.getReviewList(vo));
	    
	    return "review/review_list";
	}
		
}
