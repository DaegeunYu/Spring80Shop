package com.eighty.product;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {
	private int idx;
	private String product_code; // 제품 코드
	private String product_name; // 제품명
	private String product_img; // 제품 이미지
	private String origin; // 원산지
	private String brand; // 브랜드
	private String product_weight; // 제품 무게
	private String roast_dgree; // 커피콩 볶음 정도
	private String crushing; // 커피콩 분쇄 정도
	private String is_single_origin; // 싱글 오리진 여부 
	private String is_decafe; // 디카페인 여부
	private String manufacturing; // 제조사

	private String origin_price; // 판매가
	private String sale_price; // 할인 판매가
	
	private String quantity; // 재고량
	private String grade_point; // 별점
	
	private MultipartFile product_file;
	
	private String release_date; // 출시일
	private String expiration_date; // 유통기한
	private String reg_date; // 판매글 업로드 시간 
	
	private int start;
	private int page;
	private int amount = 8;
	private int displayPage = 8;
}
