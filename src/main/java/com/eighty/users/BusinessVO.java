package com.eighty.users;

import lombok.Data;

@Data
public class BusinessVO {
	private String businessId;    // users 테이블의 user_id와 동일한 값
    private String bizRegNo;     // 사업자 번호
    private String companyName;   // 상호명
    private String ceoName;       // 대표명
    private String bizType;       // 사업자 유형
    private String bizLicenseFile; // 파일 경로
}
