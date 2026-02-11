package com.eighty.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.eighty.product.ProductVO;
import com.eighty.review.ReviewDTO;
import com.eighty.users.UsersVO;

public interface AdminService {
	void insertProduct(ProductVO vo);
	List<UsersVO> getUsers(@Param("role") String role);
	List<ProductVO> getProducts(@Param("manufacturing") String manufacturing);
	List<String> getManufacturing();
	List<ReviewDTO> getReviews();
	
	List<Map<String, Object>> getProductStats(); // 제품별 판매량/매출 통계
    Map<String, Object> getOverallSummary();     // 전체 매출/배송량
    List<Map<String, Object>> getUserPurchases(); // 회원별 구매내역
}
