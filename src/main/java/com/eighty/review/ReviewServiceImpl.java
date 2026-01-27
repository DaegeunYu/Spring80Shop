package com.eighty.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDao  dao;

	@Override
	public List<ReviewVO> getReviewList(ReviewVO vo) {
		return dao.getReviewList(vo);
	}

	@Override
	public ReviewVO getReview(ReviewVO vo) {
		return dao.getReview(vo);
	}
}
