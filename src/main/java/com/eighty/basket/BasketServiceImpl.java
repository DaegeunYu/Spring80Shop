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

	@Override
	public void insert(RecentVO vo) {
		dao.insert(vo);
	}

	@Override
	public List<RecentVO> getProductList(RecentVO vo) {
		return dao.getProductList(vo);
	}

	@Override
	public long getMaxNumber(RecentVO vo) {
		return dao.getMaxNumber(vo);
	}

	@Override
	public int getProductCount(RecentVO vo) {
		return dao.getProductCount(vo);
	}

	@Override
	public void update(RecentVO vo) {
		dao.update(vo);
	}
}
