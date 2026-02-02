package com.eighty.basket;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eighty.shop.SQL_TYPE;

@Service
public class BasketServiceImpl implements BasketService {

	@Autowired
	private BasketDao  dao;

	@Override
	public void insert(BasketVO vo) {
		dao.insert(vo);
	}

	@Override
	public List<BasketVO> getProductList(BasketVO vo) {
		return dao.getProductList(vo);
	}

	@Override
	public void update(BasketVO vo) {
		dao.update(vo);
	}

	@Override
	public int delete(List<BasketVO> voList) {
		return dao.delete(voList);
	}
}
