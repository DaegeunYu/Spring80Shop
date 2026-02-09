package com.eighty.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eighty.admin.AdminService;
import com.eighty.product.ProductVO;
import com.eighty.users.UsersVO;


@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	@PostConstruct  
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath("/resources/files/");
	}
	
	@GetMapping(value="/product_form.do")
	public String product_form() {
		return "shop/product_form";
	}
	
	
	@GetMapping("/manager.do")
    public String adminMain(HttpSession session) {
		if (!"admin".equals(session.getAttribute("userRole"))) {
		    return "redirect:/admin/access-denied"; // 권한 없음 페이지로 리다이렉트
		}
        return "admin/main"; // 관리자 메인 layout
    }
	
	@GetMapping("/user_list.do")
    public String getUserList(Model model) {
        List<UsersVO> userList = adminService.getUsers();
        model.addAttribute("userList", userList);
        return "admin/user_list"; // 실제 파일 경로
    }
	
	@GetMapping("/product_list.do")
    public String getProductList(Model model) {
        List<ProductVO> productList = adminService.getProducts();
        model.addAttribute("productList", productList);
        return "admin/product_list";
    }

	@GetMapping("/review_list.do")
    public String getReviewList(Model model) {
//        List<ReviewVO> reviewList = adminService.getAllReviews();
//        model.addAttribute("reviews", reviewList);
        return "admin/review_list";
    }

}
