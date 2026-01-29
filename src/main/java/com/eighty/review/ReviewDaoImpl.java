package com.eighty.review;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public List<ReviewVO> getReviewList(ReviewVO vo) {
		return mybatis.selectList("REVIEW.SELECT_REVIEW_LIST", vo);
	}
	
	@Override
	public ReviewVO getReview(ReviewVO vo) {
		return mybatis.selectOne("REVIEW.SELECT_ONE_REVIEW", vo);
	}

	@Override
	public double getAverageGrade(String product_code) {
		return mybatis.selectOne("REVIEW.SELECT_AVG_GRADE", product_code);
	}

	@Override
	public void insertReview(ReviewVO vo) {
		mybatis.insert("REVIEW.INSERT_REVIEW", vo);
	}

	@Override
	public int selectReviewCount(String product_code) {
		return mybatis.selectOne("REVIEW.SELECT_REVIEW_COUNT", product_code);
	}
}
