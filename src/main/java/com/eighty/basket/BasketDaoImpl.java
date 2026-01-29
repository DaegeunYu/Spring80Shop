package com.eighty.basket;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eighty.shop.SQL_TYPE;

@Repository
public class BasketDaoImpl implements BasketDao {

	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public void insert(BasketVO vo) {
		mybatis.insert("BASKET.INSERT", vo);
	}

	@Override
	public List<BasketVO> getProductList(BasketVO vo) {
		return mybatis.selectList("BASKET.SELECT", vo);
	}

	@Override
	public void update(BasketVO vo) {
		mybatis.update("BASKET.UPDATE", vo);
	}

	@Override
	public void delete(BasketVO vo) {
		mybatis.delete("BASKET.SELECT", vo);
	}
	
}
