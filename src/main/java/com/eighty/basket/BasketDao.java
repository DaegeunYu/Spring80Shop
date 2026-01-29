package com.eighty.basket;

import java.util.List;

public interface BasketDao {
	void insert(BasketVO vo);
	List<BasketVO> getProductList(BasketVO vo);
	void update(BasketVO vo);
	void delete(BasketVO vo);
}
