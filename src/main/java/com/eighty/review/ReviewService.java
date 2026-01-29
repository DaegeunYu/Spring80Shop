package com.eighty.review;

import java.util.List;

public interface ReviewService {
	   List<ReviewVO> getReviewList(ReviewVO vo);
	   ReviewVO getReview(ReviewVO vo);
	   double getAverageGrade(String product_code);
	   void insertReview(ReviewVO vo);
	   int getReviewCount(String productCode);
}