package com.eighty.review;

import java.util.List;

public interface ReviewDao {
	   List<ReviewVO> getReviewList(ReviewVO vo);
	   ReviewVO getReview(ReviewVO vo);
	   double getAverageGrade(String product_code);
	   void insertReview(ReviewVO vo);
	   int selectReviewCount(String product_code);
	   void updateReviewStatus(ReviewVO vo);
}
