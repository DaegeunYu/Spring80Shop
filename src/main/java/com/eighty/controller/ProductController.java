package com.eighty.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eighty.basket.BasketService;
import com.eighty.basket.RecentVO;
import com.eighty.product.LikeProductVO;
import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
import com.eighty.review.ReviewService;
import com.eighty.shop.SQL_TYPE;


@RequestMapping("/product")
@Controller
public class ProductController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ProductService service;
	
	@Autowired
	private BasketService basketService;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	//메서드 자동 실행
	@PostConstruct  
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath("/resources/files/");
	}
	
	@GetMapping(value="/product_list.do")
	public String product_list(Model model, ProductVO vo){
		if (vo.getPage() < 1) {
			vo.setPage(1);
		}
		
		int count = service.count(vo, SQL_TYPE.TYPE);
		int currentPage = vo.getPage();
		
		int totalPage = (int) Math.ceil((double) count / vo.getAmount());
		int endPage = (int) (Math.ceil(currentPage / (double) vo.getDisplayPage()) * vo.getDisplayPage());
		int startPage = (endPage-vo.getDisplayPage()) + 1;
		
		if (totalPage < endPage) {
			endPage = totalPage;
		}
		boolean prev = startPage > 1;
		boolean next = endPage < totalPage;
		
		int start = (currentPage-1)*vo.getAmount();
		vo.setStart(start);
		
		model.addAttribute("product_list", service.getProductList(vo, SQL_TYPE.TYPE));
		model.addAttribute("start_page", startPage);
		model.addAttribute("end_page", endPage);
		model.addAttribute("current_page", currentPage);
		model.addAttribute("total_page", totalPage);
		model.addAttribute("type", "is");
		model.addAttribute("value", vo.getIs_single_origin());
		model.addAttribute("prev", prev);
		model.addAttribute("next", next);
		
		return "shop/product_list";
	}
	
	@GetMapping(value="/product_detail.do")
	public String product_detail(HttpSession session, Model model, ProductVO vo){
		ProductVO product = service.getProduct(vo);
	    int reviewCount = reviewService.getReviewCount(vo.getProduct_code());
	    
	    String id = (String) session.getAttribute("id");
		if (id != null) {
			RecentVO rVo = new RecentVO();
			rVo.setUser_id(id);
			rVo.setProduct_code(product.getProduct_code());
			rVo.setProduct_name(product.getProduct_name());
			rVo.setProduct_img(product.getProduct_img());
			
			int count = basketService.getProductCount(rVo);
			long number = basketService.getMaxNumber(rVo);
			rVo.setNumber(number+1);
			
			LikeProductVO lVo = new LikeProductVO();
			lVo.setUser_id(id);
			lVo.setProduct_code(product.getProduct_code());
			
			Short isLike = service.select(lVo);
			if (isLike != null) {
				model.addAttribute("like", isLike);
			} else {
				model.addAttribute("like", 0);
				service.insert(lVo);
			}
			
			if (count == 0) {
				basketService.insert(rVo);
			} else {
				basketService.update(rVo);
			}
		}
	    
	    model.addAttribute("product", product);
	    model.addAttribute("reviewCount", reviewCount);
	    return "shop/product_detail";
	}
	
	@RequestMapping("/get_price.do")
	@ResponseBody // JSON이나 일반 텍스트로 값만 반환
	public String get_price(String product_code, String product_weight) {
		int price = service.getPrice(product_code, product_weight); 
	    return String.valueOf(price);
	}
	
	
	// Like
	@GetMapping(value="/like_product.do")
	public String like_product(HttpSession session, Model model, LikeProductVO vo){
		String id = (String) session.getAttribute("id");
		vo.setUser_id(id);
		
		long count = service.getLikeCount(vo);
		int currentPage = vo.getPage();
		
		int totalPage = (int) Math.ceil((double) count / vo.getAmount());
		int endPage = (int) (Math.ceil(currentPage / (double) vo.getDisplayPage()) * vo.getDisplayPage());
		int startPage = (endPage-vo.getDisplayPage()) + 1;
		
		if (totalPage < endPage) {
			endPage = totalPage;
		}
		boolean prev = startPage > 1;
		boolean next = endPage < totalPage;
		
		int start = (currentPage-1)*vo.getAmount();
		vo.setStart(start);
		
		model.addAttribute("product_list", service.getLikeProduct(vo));
		model.addAttribute("start_page", startPage);
		model.addAttribute("end_page", endPage);
		model.addAttribute("current_page", currentPage);
		model.addAttribute("total_page", totalPage);
		model.addAttribute("prev", prev);
		model.addAttribute("next", next);
		
		return "like/like_product_list";
	}
	
	@PostMapping("/update_like.do")
	@ResponseBody
	public String update_like(HttpSession session, @RequestBody LikeProductVO vo) {
		String id = (String) session.getAttribute("id");
		vo.setUser_id(id);
	    service.update(vo);
	    return "success";
	}
	
	
}
