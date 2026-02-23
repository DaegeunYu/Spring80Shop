package com.eighty.purchase;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eighty.product.ProductService;

@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	private PurchaseDao  dao;
	
	@Autowired
	private ProductService proService; // 상품 단가를 조회

	@Override
	public List<PurchaseVO> getPurchaseList(PurchaseVO vo) {
		return dao.getPurchaseList(vo);
	}
	
	@Override
    public List<PurchaseVO> getPurchaseListSummary(String userId) {
        return dao.getPurchaseListSummary(userId);
    }

	@Override
	public void insertPurchase(List<PurchaseVO> list) {
		dao.insertPurchase(list);
		
	}

	@Override
	public List<PurchaseVO> getPurchaseListOne(PurchaseVO vo) {
		return dao.getPurchaseListOne(vo);
	}

	@Override
	public void updatePaymentInfo(PurchaseVO vo) {
		dao.updatePaymentInfo(vo);		
	}
	
	@Override
	public boolean verifyPayment(String paymentId, int expectedPrice) {
	    return true; 
	}

	@Override
	public int updateProductStock(PurchaseVO item) {
		return dao.updateProductStock(item);
	}

	@Override
	@org.springframework.transaction.annotation.Transactional // 
	public int updateOrderApproval(Map<String, Object> params) {
	    // 계좌 결제 승인 완료 후 DB 결제대기 => 결제완료 업데이트
	    int result = dao.updateOrderApproval(params);
	    
	    // 계좌 결제 승인 완료일 경우에만 물리적 재고 차감 진행
	    if (result > 0) {
	        String orderCode = (String) params.get("orderCode");
	        
	        // 해당 주문에 포함된 상품 리스트 확보
	        PurchaseVO searchVO = new PurchaseVO();
	        searchVO.setOrderCode(orderCode);
	        List<PurchaseVO> items = dao.getPurchaseList(searchVO);
	        
	        // product 테이블의 재고수량 감소
	        for (PurchaseVO item : items) {
	            // 배송비 행은 물리적 재고가 없으므로 제외
	            if (!"DELIVERY".equals(item.getProductCode())) {
	                // 숫자만 추출 (예: "200g" -> "200")
	                String weight = item.getProductWeight().replaceAll("[^0-9]", "");
	                item.setProductWeight(weight);
	                
	                // 재고 차감 실행
	                dao.updateProductStock(item);
	            }
	        }
	    }
	    
	    return result; 
	}

	@Override
	public PurchaseVO getProductDetail(PurchaseVO vo) {
		vo.setOrderCode(vo.getOrderCode());
	    vo.setProductCode(vo.getProductCode());
	    return dao.getProduct(vo);
	}
	
}
