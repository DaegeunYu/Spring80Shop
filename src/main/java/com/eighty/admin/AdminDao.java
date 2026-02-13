package com.eighty.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.eighty.product.ProductVO;
import com.eighty.review.ReviewDTO;
import com.eighty.users.UsersVO;

public interface AdminDao {
	void insertProduct(ProductVO vo);
	List<UsersVO> getUsers(@Param("role") String role);
	List<ProductVO> getProducts(@Param("manufacturing") String manufacturing);
	List<String> getManufacturing();
	List<ReviewDTO> getReviews();
	
	List<Map<String, Object>> getProductStats(); // 제품별 판매량/매출 통계
    Map<String, Object> getOverallSummary();     // 전체 매출
    List<Map<String, Object>> getProductWeightDistribution(); // 상품별 규격판매 통계
    List<Map<String, Object>> getPendingBankOrders(); // 계좌이체 결제 승인 대기목록 조회
}
