package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.eighty.product.ProductService;
import com.eighty.review.ReviewService;
import com.eighty.review.ReviewVO;


@RequestMapping("/review")
@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	@PostConstruct  
	public void init() {
		path = servletContext.getRealPath("/resources/files/");
	}
		
	@GetMapping(value="/review_list.do")
	public String review_list(Model model, ReviewVO vo) {
	    model.addAttribute("review_list", reviewService.getReviewList(vo));
	    double avgScore = reviewService.getAverageGrade(vo.getProduct_code());
	    int reviewCount = reviewService.getReviewCount(vo.getProduct_code());
	    System.out.println("avgScore==>" + avgScore);
	    System.out.println("reviewCount==>" + reviewCount);
	    
	    model.addAttribute("totalAvg", avgScore); 
	    model.addAttribute("reviewCount", reviewCount);
	    
	    return "review/review_list";
	}
	
	@GetMapping(value="/reviewForm.do")
	public String reviewForm(@RequestParam("orderCode") String orderCode, 
	                         @RequestParam("productCode") String productCode, 
	                         Model model) {
	    model.addAttribute("product", productService.getProductDetail(productCode));
	    model.addAttribute("orderCode", orderCode);
	    model.addAttribute("productCode", productCode);
	    return "review/review_form";
	}
	
	
		
}
