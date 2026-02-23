package com.eighty.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eighty.product.ProductService;
import com.eighty.review.ReviewService;
import com.eighty.review.ReviewVO;
import com.eighty.shop.ParameterValue;


@RequestMapping("/review")
@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ServletContext servletContext;
	
	private ParameterValue pv = new ParameterValue();
	
	String path ="";
			
	@PostConstruct  
	public void init() {
		path = servletContext.getRealPath(pv.getFilePath());
		
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
	public String reviewForm(@RequestParam("idx") Long idx,
	                         Model model) {
	    ReviewVO orderInfo = reviewService.getOrderDetailByIdx(idx);
	    
	    model.addAttribute("product", productService.getProductDetail(orderInfo.getProductCode()));
	    model.addAttribute("orderInfo", orderInfo);
	    return "review/review_form";
	}
	
	@PostMapping("/insertReview.do")
	public String insertReview(ReviewVO reviewVO, 
	                           @RequestParam("review_file") MultipartFile file, RedirectAttributes rttr,
	                           @AuthenticationPrincipal User user) {
	    String loginId = user.getUsername(); 
	    
	    if (loginId == null) {
	        return "redirect:/users/login.do"; 
	    }
	    reviewVO.setUserId(loginId); 
	    if (file != null && !file.isEmpty()) {
	    	String folderName = "review_" + new SimpleDateFormat("yyyyMM").format(new Date());
	        File datePath = new File(path, folderName);
	        if (!datePath.exists()) datePath.mkdirs();
	        String uuid = UUID.randomUUID().toString().replace("-", "").substring(0, 10);
	        String saveName = uuid + "_" + file.getOriginalFilename();
	        try {
	            file.transferTo(new File(datePath, saveName));
	            reviewVO.setReviewImg(folderName + "/" + saveName);
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
	
	@GetMapping("/reviewDetail.do")
    public String reviewDetail(@RequestParam("idx") int idx, Model model) {
		ReviewVO review = reviewService.getReview(idx);
	    model.addAttribute("review", review);
        // 별도의 팝업용 JSP 반환
        return "review/review_detail"; 
    }
	
	@GetMapping("/reviewDetail2.do")
	public String reviewDetail2(@RequestParam("idx") int idx, Model model) {
		ReviewVO review = reviewService.getReview2(idx);
	    model.addAttribute("review", review);
        // 별도의 팝업용 JSP 반환
        return "review/review_detail"; 
    }
	
	@PostMapping("/deleteReview.do")
	@ResponseBody
    public String deleteReview(@RequestParam("idx") int idx, HttpServletRequest request) {
		try {
	        ReviewVO review = reviewService.getReview(idx);
	        if (review.getReviewImg() != null) {
	        	pv.deletePhysicalFile(review.getReviewImg(), request);
	        }
	        
	        int result = reviewService.delReview(idx);
	        
	        return (result > 0) ? "success" : "fail";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
    }
	
	
}
