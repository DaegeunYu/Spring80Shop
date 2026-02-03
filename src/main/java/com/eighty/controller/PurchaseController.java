package com.eighty.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.SessionAttribute;

import com.eighty.basket.BasketVO;
import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
import com.eighty.purchase.PurchaseService;
import com.eighty.purchase.PurchaseVO;
import com.eighty.users.UsersService;
import com.eighty.users.UsersVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;


@RequestMapping("/purchase")
@Controller
public class PurchaseController {
	
	@Autowired
	private PurchaseService service;
	
	@Autowired
	private UsersService uservice;
	
	@Autowired
	private ProductService proservice;
	
	@Autowired
	private ServletContext servletContext;
	
	String path ="";
			
	@PostConstruct  
	public void init() {
		path = servletContext.getRealPath("/resources/files/");
	}
	
	@GetMapping(value="/purchaseList.do")
	public String getPurchaseList(
	    Model model, 
	    @SessionAttribute(name = "id", required = false) String loginId, 
	    PurchaseVO vo) {

	    if (loginId == null) {
	        return "redirect:/users/login.do";
	    }
	    
	    vo.setUserId(loginId);
	    model.addAttribute("purchaseList", service.getPurchaseList(vo));
	    return "purchase/purchase_list";
	}
	
	@GetMapping(value="/purchaseListOne.do")
	public String getpurchaseListOne(
	    @SessionAttribute(name = "id") String loginId, 
	    PurchaseVO vo,
	    Model model) {
	    vo.setUserId(loginId);
	    model.addAttribute("purchaseOne", service.getPurchaseListOne(vo));
	    return "purchase/purchase_list_one";
	}
	
	@RequestMapping("/purchase.do")
	public String purchaseForm(HttpSession session, Model model, 
							   String product_code, String product_count,
							   @RequestParam(value="crushing", required=false) String crushing,
	                           @RequestParam(value="product_weight", required=false) String product_weight,
							   @RequestParam(value="jsonPayload", required=false) String basketJson) {
	    // 로그인한 사용자 확인
	    String id = (String) session.getAttribute("id");
	    if (id == null) {
	        return "redirect:/users/login.do";// 비 로그인 시 로그인페이지로 이동
	    } 
	    //사용자 정보
        UsersVO buyer = new UsersVO();
        buyer.setUser_id(id);//유저 조회 대상 지정
        model.addAttribute("users", uservice.getSelectOne(buyer)); //DB에서 회원 정보 조회 후 객체를 model에 저장
	    
        List<Map<String, Object>> purchaseList = new ArrayList<Map<String, Object>>();
        
        // 장바구니에서 여러 상품이 넘어온 경우
        if (basketJson != null && !basketJson.isEmpty()) {
            try {
                ObjectMapper mapper = new ObjectMapper();
                List<BasketVO> basketList = mapper.readValue(basketJson, new TypeReference<List<BasketVO>>(){});

                for (BasketVO b : basketList) {
                	ProductVO pvo = new ProductVO(); 
                    pvo.setProduct_code(b.getProduct_code()); 
                    ProductVO p = proservice.getProduct(pvo);
                    
                    Map<String,Object> map = new HashMap<String,Object>();
                    map.put("basket", b);  
                    map.put("product", p);  
                    purchaseList.add(map);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else { // 상세페이지에서 바로구매로 단일 상품 결제
            ProductVO pvo = new ProductVO();
            pvo.setProduct_code(product_code);
            ProductVO p = proservice.getProduct(pvo);

            BasketVO b = new BasketVO();
            b.setProduct_code(product_code);
            b.setProduct_count(product_count);
            b.setCrushing(crushing); 
            b.setProduct_weight(product_weight);
            
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("basket", b);   
            map.put("product", p); 
            purchaseList.add(map);
        }

        model.addAttribute("purchaseList", purchaseList);
        return "purchase/purchase_detail";
	}
	
	@PostMapping("/purchase_basket_list.do")
    public String purchase_basket_list(@RequestParam("jsonPayload") String jsonPayload, HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		
		try {
	        // 1. JSON 문자열을 List<BasketVO>로 변환
	        ObjectMapper mapper = new ObjectMapper();
	        List<BasketVO> voList = mapper.readValue(jsonPayload, new TypeReference<List<BasketVO>>(){});
	        
	        UsersVO buyer = new UsersVO();
	        buyer.setUser_id(id);
	        model.addAttribute("users", uservice.getSelectOne(buyer));
	        model.addAttribute("purchaseList", voList);
	        
	        return "purchase/purchase_detail";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/index.do?page=1";
	    }
    }
	
	@PostMapping("/purchase_insert.do")
	public String insertPurchase(
	        @RequestParam("product_code") String[] productCode,
	        @RequestParam("productName") String[] productName,
	        @RequestParam("productWeight") String[] productWeight,
	        @RequestParam("product_count") String[] productCount,
	        @RequestParam("total_price") String[] totalPrice,
	        @RequestParam("crushing") String[] crushing,
	        @RequestParam("paymentMethod") String paymentMethod,
	        @RequestParam("paymentStatus") String paymentStatus,
	        PurchaseVO buyerInfo, // JSP의 receiverName, receiverPhone, address, orderMemo 등을 자동 수신
	        HttpSession session) {

	    String userId = (String) session.getAttribute("id");
	    List<PurchaseVO> purchaseList = new java.util.ArrayList<PurchaseVO>();

	    for (int i = 0; i < productCode.length; i++) {
	    PurchaseVO item = new PurchaseVO();
	    
	    // 공통 및 배송 정보 (PurchaseVO에서 실제 존재하는 메서드 호출)
	    item.setOrderCode(buyerInfo.getOrderCode());
	    item.setUserId(userId);
	    item.setReceiverName(buyerInfo.getReceiverName());   
	    item.setReceiverPhone(buyerInfo.getReceiverPhone()); 
	    item.setAddress(buyerInfo.getAddress());             
	    item.setOrderMemo(buyerInfo.getOrderMemo());         
	    
	    // 결제 상태 정보
	    item.setPaymentMethod(paymentMethod);
	    item.setOrderStatus(paymentStatus);
	    item.setIsReview("n");

	    // 개별 상품 정보 
	    item.setProductCode(productCode[i]);
	    item.setProductName(productName[i]);
	    item.setProductWeight(productWeight[i]);
	    item.setCrushing(crushing[i]);
	    item.setOrderCount(productCount[i]); 
	    item.setOrderPrice(totalPrice[i]);  

	    purchaseList.add(item);
	    }
	    
	    service.insertPurchase(purchaseList);

	    return "redirect:/purchase/purchaseList.do";
	}
}
