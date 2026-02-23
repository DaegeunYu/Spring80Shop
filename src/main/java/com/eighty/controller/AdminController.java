package com.eighty.controller;

import java.io.File;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

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

import com.eighty.admin.AdminService;
import com.eighty.product.ProductService;
import com.eighty.product.ProductVO;
import com.eighty.purchase.PurchaseService;
import com.eighty.review.ReviewDTO;
import com.eighty.shop.ParameterValue;
import com.eighty.users.UsersService;
import com.eighty.users.UsersVO;

@RequestMapping("/admin")
@Controller
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private ProductService productService;

	@Autowired
	private UsersService usersService;

	@Autowired
	private PurchaseService purchaseService;

	@Autowired
	private ServletContext servletContext;

	private ParameterValue pv = new ParameterValue();

	String path = "";

	@PostConstruct
	public void init() {
		// 가독성 때문에 init() 이란 이름 부여
		path = servletContext.getRealPath(pv.getFilePath());
	}

	@GetMapping(value = "/product_form.do")
	public String product_form(String product_code, Model model) {
		if (product_code != null) {
			ProductVO vo = new ProductVO();
			vo = productService.getProductDetail(product_code);
			vo.setOptionList(productService.getProductOption(product_code));
			model.addAttribute("product", vo);
			model.addAttribute("mode", "edit");
		}
		return "shop/product_form";
	}

	@GetMapping(value = "/user_form.do")
	public String user_form(String user_id, Model model) {
		UsersVO vo = new UsersVO();
		vo.setUser_id(user_id);
		vo = usersService.getSelectOne(vo);
		model.addAttribute("user", vo);
		return "users/user_form";
	}

	@GetMapping("/manager.do")
	public String adminMain() {
		// 모든 검증은 시큐리티에서 진행
		return "admin/main";
	}

	@GetMapping("/access-denied.do")
	public String accessDenied() {
		return "admin/access-denied";
	}

	@GetMapping("/user_list.do")
	public String getUserList(@RequestParam(value = "role", required = false) String role, Model model) {
		List<UsersVO> userList = adminService.getUsers(role);
		model.addAttribute("userList", userList);
		return "admin/user_list"; // 실제 파일 경로
	}

	@GetMapping("/product_list.do")
	public String getProductList(@RequestParam(value = "manufacturing", required = false) String manufacturing,
			Model model) {
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
			@AuthenticationPrincipal User user) {

		String loginId = user.getUsername();
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

	@PostMapping("/changeProduct.do")
	@ResponseBody
	public String changeProduct(ProductVO PVO, @RequestParam("product_img_file") MultipartFile file,
			@AuthenticationPrincipal User user) {

		String loginId = user.getUsername();
		if (loginId == null) {
			return "login_required"; // 자바스크립트에서 처리할 신호
		}

		try {
			if (file != null && !file.isEmpty() && PVO.getProduct_img() != null) {
				File delFile = new File(path, PVO.getProduct_img());
				if (delFile.exists()) {
					delFile.delete();
				}
				productService.update(PVO, file);
				File licenseFolder = new File(path, "product"); // 설정된 path 사용
				if (!licenseFolder.exists()) {
					licenseFolder.mkdirs();
				}

				File saveFile = new File(path, PVO.getProduct_img());
				file.transferTo(saveFile);
			} else {
				productService.update(PVO, file);
			}

			return "success"; // 성공 시 문자열 리턴
		} catch (Exception e) {
			e.printStackTrace();
			return "error: " + e.getMessage(); // 에러 발생 시 메시지 리턴
		}
	}

	@PostMapping("/deleteProduct.do")
	@ResponseBody
	public String deleteProduct(@RequestParam("product_code") String product_code, HttpServletRequest request) {
		try {
			ProductVO product = new ProductVO();
			product.setProduct_code(product_code);
			ProductVO productResult = productService.getProduct(product);

			if (productResult.getProduct_img() != null) {
				pv.deletePhysicalFile(productResult.getProduct_img(), request);
			}

			int result = productService.delProduct(productResult.getIdx(), productResult.getProduct_code());

			return (result > 0) ? "success" : "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	@PostMapping("/deleteUser.do")
	@ResponseBody
	public String deleteUser(@RequestParam("user_id") String user_id) {
		try {
			UsersVO user = new UsersVO();
			user.setUser_id(user_id);

			int result = usersService.delete(user);

			return (result > 0) ? "success" : "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
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
		// 제품별 통계 (판매율 원형 차트용)
		model.addAttribute("productStats", adminService.getProductStats());
		// 상품별 규격 분포 통계 (누적 막대 차트용)
		model.addAttribute("weightDist", adminService.getProductWeightDistribution());

		return "admin/product_sales";
	}

	@GetMapping("/order_approval.do")
	public String orderApprovalList(Model model) {
		// 계좌이체로 주문된 데이터조회
		List<Map<String, Object>> approvalList = adminService.getPendingBankOrders();

		model.addAttribute("approvalList", approvalList);

		return "admin/order_approval";
	}

	@PostMapping("/approveOrder.do")
	@ResponseBody
	public String approveOrder(@RequestParam("orderCode") String orderCode) {
		try {
			// 관리자 승인에 필요한 메타데이터 구성
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("orderCode", orderCode);
			params.put("approvalId", "ADM" + System.currentTimeMillis()); // 관리자 승인 식별자
			params.put("approvalDate",
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));

			// DB 업데이트 및 재고 차감
			int result = purchaseService.updateOrderApproval(params);

			return (result > 0) ? "success" : "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	@PostMapping("/approveBulkOrders.do")
	@ResponseBody
	public String approveBulkOrders(@RequestParam(value = "orderCodes") List<String> orderCodes) {
		if (orderCodes == null || orderCodes.isEmpty()) {
			return "fail";
		}

		try {
			int totalResult = 0;
			long baseTime = System.nanoTime(); // 나노초 단위로 고유성 확보
			String now = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

			for (int i = 0; i < orderCodes.size(); i++) {
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("orderCode", orderCodes.get(i));
				// 고유 식별자: 나노초 + 인덱스로 절대 중복 방지
				params.put("approvalId", "ADM_B" + baseTime + "_" + i);
				params.put("approvalDate", now);

				// 각 주문 건에 대해 승인 처리 실행
				totalResult += purchaseService.updateOrderApproval(params);
			}

			// 로그 기록: 실제 처리된 건수 확인용
			System.out.println("일괄 승인 요청: " + orderCodes.size() + "건 / 실제 처리: " + totalResult + "건");

			// 한 건이라도 처리가 되었다면 화면을 갱신시키기 위해 success 반환
			return (totalResult > 0) ? "success" : "fail";

		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

}
