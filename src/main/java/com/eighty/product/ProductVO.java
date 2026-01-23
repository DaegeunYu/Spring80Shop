package com.eighty.product;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {
  private  int  idx  ;
  private String  product_id  ;
  private String  category; /* 전통주, 양주, 와인, 맥주 */
  private String  product_name ;
  private int product_price  ;
  private String product_desc  ;
  private int quantity  ;

  private  MultipartFile    product_file  ;
  private  String product_img  ;

  private  String product_admin ; /* 관리자 , 과장1, 과장2 */
  private  String reg_date ;
  
  private String cart_id  ;
  private String user_id ; 
  private String amount;
}
