package com.eighty.basket;

import java.util.List;

import com.eighty.shop.SQL_TYPE;

public interface BasketService {
	void insert(BasketVO vo);
	List<BasketVO> getProductList(BasketVO vo);
	void update(BasketVO vo);
	int delete(List<BasketVO> voList);
}
