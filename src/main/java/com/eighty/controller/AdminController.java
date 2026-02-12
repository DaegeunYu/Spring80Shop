package com.eighty.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eighty.admin.AdminService;
import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
import com.eighty.review.ReviewDTO;
import com.eighty.shop.ParameterValue;
import com.eighty.users.UsersVO;


@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ServletContext servletContext;
	
	private ParameterValue pv = new ParameterValue();
	
	String path ="";
			
	@PostConstruct  
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath(pv.getFilePath());
	}
	
	@GetMapping(value="/product_form.do")
	public String product_form() {
		return "shop/product_form";
	}
	
	
	@GetMapping("/manager.do")
    public String adminMain(HttpSession session) {
		if (!"admin".equals(session.getAttribute("userRole"))) {
		    return "/admin/access-denied"; // 권한 없음 페이지로 리다이렉트
		}
        return "admin/main"; // 관리자 메인 layout
    }
	
	@GetMapping("/user_list.do")
    public String getUserList(@RequestParam(value="role", required=false) String role, Model model) {
		List<UsersVO> userList = adminService.getUsers(role);
        model.addAttribute("userList", userList);
        return "admin/user_list"; // 실제 파일 경로
    }
	
	@GetMapping("/product_list.do")
    public String getProductList(@RequestParam(value="manufacturing", required=false) String manufacturing, Model model) {
        List<ProductVO> productList = adminService.getProducts(manufacturing);
        model.addAttribute("productList", productList);
        return "admin/product_list";
    }
	
	@GetMapping(value = "/getManufacturing.do", produces = "application/json; charset=UTF-8")
	@ResponseBody // JSON 형태로 반환
	public List<String> getManufacturing() {
	    return adminService.getManufacturing();
	}

	@GetMapping("/review_list.do")
    public String getReviewList(Model model) {
        List<ReviewDTO> reviewList = adminService.getReviews();
        model.addAttribute("reviewList", reviewList);
        return "admin/review_list";
    }
	
	@PostMapping("/insertProduct.do")
	@ResponseBody
	public String insertProduct(ProductVO PVO, @RequestParam("product_img_file") MultipartFile file, 
	                            HttpSession session) {
	    	    
		String loginId = (String) session.getAttribute("id"); 
	    if (loginId == null) {
	        return "login_required"; // 자바스크립트에서 처리할 신호
	    }
	    
	    try {	        
	        productService.insert(PVO, file);
	        if (file != null && !file.isEmpty() && PVO.getProduct_img() != null) {
	            File licenseFolder = new File(path, "product"); // 설정된 path 사용
	            if (!licenseFolder.exists()) {
	                licenseFolder.mkdirs();
	            }
	            File saveFile = new File(path, PVO.getProduct_img());
	            file.transferTo(saveFile);
	        }	        
	        return "success"; // 성공 시 문자열 리턴
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error: " + e.getMessage(); // 에러 발생 시 메시지 리턴
	    }
	}
	
	@GetMapping("/sales_list.do") 
	public String getSalesList(Model model) {
        // 전체 요약 (총 매출, 주문 수 등)
        model.addAttribute("summary", adminService.getOverallSummary());
        
        return "admin/sales_list";
    }
	
	@GetMapping("/product_sales.do") 
	public String getProductStats(Model model) {
		// 전체 요약 (총 매출, 주문 수 등)
        model.addAttribute("summary", adminService.getOverallSummary());
        // 제품별 통계 (차트용)
        model.addAttribute("productStats", adminService.getProductStats());
        
        return "admin/product_sales";
    }
}
