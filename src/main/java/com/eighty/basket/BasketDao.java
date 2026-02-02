package com.eighty.basket;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BasketDao {
	void insert(BasketVO vo);
	List<BasketVO> getProductList(BasketVO vo);
	void update(BasketVO vo);	
	int delete(List<BasketVO> voList);
}
