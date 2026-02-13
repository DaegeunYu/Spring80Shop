package com.eighty.product;

import lombok.Data;

@Data
public class LikeProductVO {
	private long idx;
	private String user_id;
	private String product_code;
	private short is_like;
	
	private int start;
	private int page;
	private int amount = 8;
	private int displayPage = 8;
}
