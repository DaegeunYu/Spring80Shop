package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
			
	@PostConstruct  
	public void init() {
		path = servletContext.getRealPath("/resources/files/");
	}
		
	@GetMapping(value="/review_list.do")
	public String review_list(Model model, ReviewVO vo) {
	    model.addAttribute("review_list", service.getReviewList(vo));
	    double avgScore = service.getAverageGrade(vo.getProduct_code());
	    int reviewCount = service.getReviewCount(vo.getProduct_code());
	    System.out.println("avgScore==>" + avgScore);
	    System.out.println("reviewCount==>" + reviewCount);
	    
	    model.addAttribute("totalAvg", avgScore); 
	    model.addAttribute("reviewCount", reviewCount);
	    
	    return "review/review_list";
	}
		
}
