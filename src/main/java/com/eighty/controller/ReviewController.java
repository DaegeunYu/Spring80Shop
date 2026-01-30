package com.eighty.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		System.out.println("이미지가 실제로 저장되는 절대 경로: " + path);
	    model.addAttribute("reviewList", reviewService.getReviewList(vo));
	    double avgScore = reviewService.getAverageGrade(vo.getProductCode());
	    int reviewCount = reviewService.getReviewCount(vo.getProductCode());
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
	
	@PostMapping("/insertReview.do")
	public String insertReview(ReviewVO reviewVO, 
	                           @RequestParam("review_file") MultipartFile file, RedirectAttributes rttr,
	                           HttpSession session) {
	    String loginId = (String) session.getAttribute("id"); 
	    
	    if (loginId == null) {
	        return "redirect:/users/login.do"; 
	    }
	    reviewVO.setUserId(loginId); 
	    if (file != null && !file.isEmpty()) {
	        String today = new SimpleDateFormat("yyyyMMdd").format(new Date());
	        File datePath = new File(path, today);
	        if (!datePath.exists()) datePath.mkdirs();
	        String uuid = UUID.randomUUID().toString().replace("-", "").substring(0, 10);
	        String saveName = uuid + "_" + file.getOriginalFilename();
	        try {
	            file.transferTo(new File(datePath, saveName));
	            reviewVO.setReviewImg(today + "/" + saveName);
	        } catch (IOException e) {
	            System.out.println("파일 저장 중 오류 발생: " + e.getMessage());
	            e.printStackTrace();
	        }
	    }
	    reviewService.insertReview(reviewVO);

	    rttr.addAttribute("product_code", reviewVO.getProductCode());
	    rttr.addFlashAttribute("msg", "리뷰가 등록되었습니다.");

	    return "redirect:/product/product_detail.do";
	}
	
	@GetMapping(value="/reviewCheck.do")
	public String reviewCheck(ReviewVO vo, RedirectAttributes rttr) {
		String productCode = vo.getProductCode();
		System.out.println("productcode==>" + productCode);
	    rttr.addAttribute("product_code", productCode);
	    
	    return "redirect:/product/product_detail.do";
	}
		
}
