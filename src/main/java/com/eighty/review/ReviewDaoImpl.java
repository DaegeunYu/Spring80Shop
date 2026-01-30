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
	public double getAverageGrade(String productCode) {
		return mybatis.selectOne("REVIEW.SELECT_AVG_GRADE", productCode);
	}

	@Override
    public void insertReview(ReviewVO vo) {
        mybatis.insert("REVIEW.insertReview", vo);
    }

	@Override
	public int selectReviewCount(String productCode) {
		return mybatis.selectOne("REVIEW.SELECT_REVIEW_COUNT", productCode);
	}

	@Override
	public void updateReviewStatus(ReviewVO vo) {
		mybatis.update("REVIEW.UPDATE_REVIEW_STATUS", vo);
		
	}
}
