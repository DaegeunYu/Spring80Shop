package com.eighty.review;

import java.util.List;

public interface ReviewDao {
	   List<ReviewVO> getReviewList(ReviewVO vo);
	   ReviewVO getReview(ReviewVO vo);
	   double getAverageGrade(String productCode);
	   void insertReview(ReviewVO vo);
	   int selectReviewCount(String productCode);
	   void updateReviewStatus(ReviewVO vo);
}
