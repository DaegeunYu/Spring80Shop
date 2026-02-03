package com.eighty.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eighty.basket.BasketService;
import com.eighty.basket.RecentVO;
import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
import com.eighty.shop.SQL_TYPE;


@Controller
public class StartController {
	
	@Autowired
	private ProductService service;
	
	@Autowired
	private BasketService basketService;
	
	StartController(){
		System.out.println("==> StartController");
	}
	
	@GetMapping(value="/index.do")
	public String index(HttpSession session, Model model, ProductVO vo) {
		String id = (String) session.getAttribute("id");
		
		if (id != null ) {
			RecentVO rVo = new RecentVO();
			rVo.setUser_id(id);
			List<RecentVO> list = new ArrayList<RecentVO>();
			list = basketService.getProductList(rVo);
			if (!list.isEmpty()) {
				model.addAttribute("recent_product_list", list);
				vo.setAmount(4);
			}
		}
		
		vo.setManufacturing("(주)80s");
		if (vo.getPage() < 1) {
			vo.setPage(1);
		}
		
		int count = service.count(vo, SQL_TYPE.MAN);
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
		
		model.addAttribute("product_list", service.getProductList(vo, SQL_TYPE.MAN));
		model.addAttribute("start_page", startPage);
		model.addAttribute("end_page", endPage);
		model.addAttribute("current_page", currentPage);
		model.addAttribute("total_page", totalPage);
		model.addAttribute("type", "man");
		model.addAttribute("prev", prev);
		model.addAttribute("next", next);
		
		return "index";
	}
}
