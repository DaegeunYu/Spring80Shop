package com.eighty.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eighty.basket.BasketVO;
import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
import com.eighty.purchase.PurchaseService;
import com.eighty.purchase.PurchaseVO;
import com.eighty.shop.ParameterValue;
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
	
	private ParameterValue pv = new ParameterValue();
	
	String path ="";
			
	@PostConstruct  
	public void init() {
		path = servletContext.getRealPath(pv.getFilePath());
	}
	
	@GetMapping(value="/purchaseList.do")
	public String purchaseList(@AuthenticationPrincipal User user, Model model) {
		if(user == null) {
	        return "redirect:/users/login.do";
	    }
		
		String userId = user.getUsername(); // 시큐리티의 username(ID) 추출
		
	    List<PurchaseVO> list = service.getPurchaseListSummary(userId);
	    model.addAttribute("purchaseList", list);
	    
	    return "purchase/purchase_list";
	}
	
	@GetMapping(value="/purchaseListOne.do")
	public String getpurchaseListOne(
		@AuthenticationPrincipal User user, PurchaseVO vo, Model model) {
		if(user == null) return "redirect:/users/login.do";
		
	    vo.setUserId(user.getUsername());
	    List<PurchaseVO> list = service.getPurchaseListOne(vo);
	    model.addAttribute("purchaseList", list);
	    model.addAttribute("orderInfo", list.get(0));
	    return "purchase/purchase_list_one";
	}
	
	@RequestMapping("/purchase.do")
	public String purchaseForm(@AuthenticationPrincipal User user, HttpSession session, Model model, 
							   String product_code, String product_count,
							   @RequestParam(value="crushing", required=false) String crushing,
	                           @RequestParam(value="product_weight", required=false) String product_weight,
							   @RequestParam(value="jsonPayload", required=false) String basketJson) {
	    
	    if (user == null) {
	    	//마지막으로 본 페이지
	    	String detailUrl = "/product/product_detail.do?product_code=" + product_code;
	        session.setAttribute("prevPage", detailUrl);
	        return "redirect:/users/login.do";// 비 로그인 시 로그인페이지로 이동
	    }
	    // 로그인한 사용자 확인
	    String id = user.getUsername();
	    //사용자 정보
        UsersVO buyer = new UsersVO();
        buyer.setUser_id(id);//유저 조회 대상 지정
        model.addAttribute("users", uservice.getSelectOne(buyer)); //DB에서 회원 정보 조회 후 객체를 model에 저장
	    
        List<Map<String, Object>> purchaseList = new ArrayList<Map<String, Object>>();
        int total_price = 0; 
        
        // 장바구니에서 여러 상품이 넘어온 경우
        if (basketJson != null && !basketJson.isEmpty()) {
            try {
                ObjectMapper mapper = new ObjectMapper();
                List<BasketVO> basketList = mapper.readValue(basketJson, new TypeReference<List<BasketVO>>(){});

                for (BasketVO b : basketList) {
                	ProductVO pvo = new ProductVO(); 
                    pvo.setProduct_code(b.getProduct_code()); 
                    ProductVO p = proservice.getProduct(pvo);
                    
                    // 서버에서 가격 재계산 (무게 기준 최신 단가 추출)
                    int currentPrice = proservice.getPrice(b.getProduct_code(), b.getProduct_weight());
                    p.setSale_price(String.valueOf(currentPrice)); // ProductVO의 가격정보를 최신화
                    
                    total_price += (currentPrice * Integer.parseInt(b.getProduct_count()));
                    
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
            
            // 서버에서 가격 재계산 (무게 기준 최신 단가 추출)
            int currentPrice = proservice.getPrice(product_code, product_weight);
            p.setSale_price(String.valueOf(currentPrice)); // ProductVO의 가격정보를 최신화
            
            total_price = currentPrice * Integer.parseInt(product_count);
            
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
        model.addAttribute("total_price", total_price);
        model.addAttribute("final_total_price", total_price + 5000); //배송비 5000원 추가
        
        // 결제창 호출 시 사용할 임시 주문번호 생성 (purchase_detail_payment.jsp의 ${orderCode}로 전달됨)
        String orderCode = "ORD" + new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").format(new java.util.Date());
        model.addAttribute("orderCode", orderCode);
        return "purchase/purchase_detail";
	}
	
	@PostMapping("/purchase_basket_list.do")
    public String purchase_basket_list(@AuthenticationPrincipal User user, @RequestParam("jsonPayload") String jsonPayload, Model model) {
		if (user == null) return "redirect:/users/login.do";
		
		
		try {
	        // 1. JSON 문자열을 List<BasketVO>로 변환
	        ObjectMapper mapper = new ObjectMapper();
	        List<BasketVO> voList = mapper.readValue(jsonPayload, new TypeReference<List<BasketVO>>(){});
	        
	        UsersVO buyer = new UsersVO();
	        buyer.setUser_id(user.getUsername());
	        model.addAttribute("users", uservice.getSelectOne(buyer));
	        model.addAttribute("purchaseList", voList);
	        
	        // 결제창 호출 시 사용할 임시 주문번호 생성 (purchase_detail_payment.jsp의 ${orderCode}로 전달됨)
	        String orderCode = "ORD" + new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").format(new java.util.Date());
	        model.addAttribute("orderCode", orderCode);
	        
	        return "purchase/purchase_detail";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/index.do?page=1";
	    }
    }
	
	@PostMapping("/purchase_insert.do")
	public String insertPurchase(@AuthenticationPrincipal User user,
			@RequestParam("product_code") String[] productCode,
	        @RequestParam("productWeight") String[] productWeight,
	        @RequestParam("product_count") String[] productCount,
	        @RequestParam("crushing") String[] crushing,
	        @RequestParam("paymentMethod") String paymentMethod,
	        @RequestParam("paymentStatus") String paymentStatus,
	        @RequestParam(value="orderCode", required=false) String orderCode,
	        @RequestParam("receiptId") String receiptId,
	        @RequestParam("approvalId") String approvalId,
	        @RequestParam("approvalDate") String approvalDate,
	        @RequestParam("paidAmount") int paidAmount,
	        @RequestParam("pgStatus") String pgStatus,
	        PurchaseVO buyerInfo, // JSP의 receiverName, receiverPhone, address, orderMemo 등을 자동 수신
	        RedirectAttributes purchaseInfo) {
		if (user == null) return "redirect:/users/login.do";
	    String userId = user.getUsername();
	    List<PurchaseVO> purchaseList = new java.util.ArrayList<PurchaseVO>();

	    // 외부에서 넘어온 번호가 없으면(계좌이체 등) 난수 새로 생성, 있으면 그대로 사용
	    String uniqueOrderCode = (orderCode == null || orderCode.isEmpty()) 
	        ? "ORD" + new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").format(new java.util.Date())
	        : orderCode;
	    
	    int totalProductSum = 0;
	    
	    for (int i = 0; i < productCode.length; i++) {
	    PurchaseVO item = new PurchaseVO();
	    
	    // 공통 및 배송 정보 (PurchaseVO에서 실제 존재하는 메서드 호출)
	    item.setOrderCode(uniqueOrderCode);
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
	    item.setProductWeight(productWeight[i]);
	    item.setCrushing(crushing[i]);
	    item.setOrderCount(productCount[i]);
	    
	    // 포트원 결제 상세 정보
        item.setReceiptId(receiptId);
        item.setApprovalId(approvalId);
        item.setApprovalDate(approvalDate);
        item.setPaidAmount(paidAmount);
        item.setPgStatus(pgStatus);
        item.setCancelAmount(0); //환불금액
	    
	    ProductVO searchVO = new ProductVO();
        searchVO.setProduct_code(productCode[i]);
        ProductVO dbProduct = proservice.getProduct(searchVO); 
        item.setProductName(dbProduct.getProduct_name()); //DB에서 상품명 직접 가져옴
        
	    
	    int realPrice = proservice.getPrice(productCode[i], productWeight[i]);
        int count = Integer.parseInt(productCount[i]);
        int itemTotal = realPrice * count;
        
        item.setOrderPrice(String.valueOf(itemTotal)); 
        item.setPaidAmount(itemTotal);
        
        totalProductSum += itemTotal; 
	    purchaseList.add(item);
	    }
	    
	    // 배송비 전용 행 추가 로직 (장바구니 다수장품 동시 구매 시 배송비 한번만 적용)
	    int deliveryFee = 5000; // 배송비 설정
	    if (deliveryFee > 0) {
	        PurchaseVO deliveryRow = new PurchaseVO();
	        
	        // 공통 정보 
	        PurchaseVO firstItem = purchaseList.get(0);
	        deliveryRow.setOrderCode(firstItem.getOrderCode());
	        deliveryRow.setUserId(firstItem.getUserId());
	        deliveryRow.setReceiverName(firstItem.getReceiverName());
	        deliveryRow.setReceiverPhone(firstItem.getReceiverPhone());
	        deliveryRow.setAddress(firstItem.getAddress());
	        deliveryRow.setOrderMemo(firstItem.getOrderMemo());
	        deliveryRow.setPaymentMethod(firstItem.getPaymentMethod());
	        deliveryRow.setOrderStatus(firstItem.getOrderStatus());
	        deliveryRow.setIsReview("n");
	        deliveryRow.setReceiptId(firstItem.getReceiptId());
	        deliveryRow.setApprovalId(firstItem.getApprovalId());
	        deliveryRow.setApprovalDate(firstItem.getApprovalDate());
	        deliveryRow.setPgStatus(firstItem.getPgStatus());
	        deliveryRow.setCancelAmount(0);

	        // 배송비 전용 데이터
	        deliveryRow.setProductCode("DELIVERY"); // 가상의 배송비 코드
	        deliveryRow.setProductName("배송비");
	        deliveryRow.setProductWeight("N/A");
	        deliveryRow.setCrushing("N/A");
	        deliveryRow.setOrderCount("1"); // 배송 횟수 계산용
	        deliveryRow.setOrderPrice("0");
	        deliveryRow.setPaidAmount(deliveryFee); // 배송비 금액만 입력

	        // 리스트에 추가
	        purchaseList.add(deliveryRow);
	    }
	    
	    service.insertPurchase(purchaseList);
	    
	    // 신용카드 주문 완료 시 재고 차감
	    if ("PAID".equals(pgStatus)) {
	    	for (int i = 0; i < productCode.length; i++) {
	    		// 배송비 행은 제외 
	    		if (!"DELIVERY".equals(productCode[i])) {
	            
	    			PurchaseVO item = new PurchaseVO();
	    			item.setProductCode(productCode[i]);
	    			item.setOrderCount(productCount[i]);
	            
	    			String pureWeight = productWeight[i].replaceAll("[^0-9]", ""); 
	    			item.setProductWeight(pureWeight);
	            
	    			service.updateProductStock(item); 
	    		}
	    	}	
	    }
	    
	    purchaseInfo.addAttribute("orderCode", uniqueOrderCode);
	    
	    purchaseInfo.addFlashAttribute("finalPrice", totalProductSum + 5000);
	    purchaseInfo.addFlashAttribute("receiverName", buyerInfo.getReceiverName());

	    return "redirect:/purchase/purchase_success.do";
	}
	
	@GetMapping("/purchase_success.do")
	public String purchaseSuccess(@AuthenticationPrincipal User user, 
	        @RequestParam("orderCode") String orderCode, 
	        Model model) {
	    
	    String userId = user.getUsername();
	    
	    // 1. 이번 주문번호와 아이디를 조건으로 설정 (방금 결제한 내역만 필터링)
	    PurchaseVO searchVO = new PurchaseVO();
	    searchVO.setOrderCode(orderCode);
	    searchVO.setUserId(userId); 

	    // 2. DB에서 이번 주문 건만 가져옴 (상품이 여러 개면 여러 줄이 나옴)
	    List<PurchaseVO> dbPurchaseList = service.getPurchaseList(searchVO); 
	    
	    // 3. purchase.do와 동일한 Map 구조 생성
	    List<Map<String, Object>> successMapList = new ArrayList<Map<String, Object>>();
	    
	    if (dbPurchaseList != null && !dbPurchaseList.isEmpty()) {
	        for (PurchaseVO pvo : dbPurchaseList) {
	            Map<String, Object> map = new HashMap<String, Object>();
	            
	            // 각 주문 내역에 연결된 실제 상품 정보(이미지 등)를 DB에서 다시 가져옴
	            ProductVO productSearch = new ProductVO();
	            productSearch.setProduct_code(pvo.getProductCode());
	            ProductVO productDetail = proservice.getProduct(productSearch);
	            
	            map.put("purchase", pvo);      // 주문 정보 (수량, 선택옵션, 가격 등)
	            map.put("product", productDetail); // 상품 정보 (이미지, 실제 상품명 등)
	            
	            successMapList.add(map);
	        }
	        
	        // 4. JSP로 전송
	        model.addAttribute("orderItems", successMapList); // 상품 리스트 (Map 리스트)
	        model.addAttribute("orderInfo", dbPurchaseList.get(0)); // 공통 배송지/결제 정보
	    } else {
	        // 비정상 접근 시 메인으로
	        return "redirect:/index.do";
	    }
	    
	    return "purchase/purchase_success"; 
	}
	
	@ResponseBody
    @PostMapping("/purchase_success.do")
    public String completePayment(@RequestBody Map<String, Object> data) {
        String paymentId = (String) data.get("paymentId");
        System.out.println("==> 결제 검증 수신 (Success 주소 활용): " + paymentId);
        
        // 무조건 success 문자열 반환하여 JS의 submit() 유도
        return "success"; 
    }
	
}
