package com.eighty.product;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {
	private int idx;
	private String product_code; // 제품 코드
	private String product_name; // 제품명
	private String product_img; // 제품 이미지
	private String origin; // 원산지
	private String brand; // 브랜드
	//private String product_weight; // 제품 무게 ( 최하단 ProductOption으로 이동했기에 일단 주석처리)
	private String roast_dgree; // 커피콩 볶음 정도
	private String crushing; // 커피콩 분쇄 정도
	private String is_single_origin; // 싱글 오리진 여부 
	private String is_decafe; // 디카페인 여부
	private String manufacturing; // 제조사
	
	//private String product_price; // 옵션별 가격 ( 최하단 ProductOption으로 이동했기에 일단 주석처리)
	private String origin_price; // 판매가
	private String sale_price; // 할인 판매가
	
	private String quantity; // 재고량
	private String grade_point; // 별점
	
	private String release_date; // 출시일
	private String expiration_date; // 유통기한
	private String reg_date; // 판매글 업로드 시간 
	
	private int start;
	private int page;
	private int amount = 8;
	private int displayPage = 8;
	
	// 리스트 초기화 ( null 방지용 ) 및  review_from.jsp에서 사용
	private List<ProductOption> optionList = new ArrayList<ProductOption>();
	public String getFirstWeight() {
        if (this.optionList != null && !this.optionList.isEmpty()) {
            return this.optionList.get(0).getProduct_weight();
        }
        return "옵션 없음";
    }
	
	@Data
    public static class ProductOption {
        private String product_code;
        private String product_weight;
        private String product_price;
    }
}
