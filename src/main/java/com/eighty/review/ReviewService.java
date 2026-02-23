package com.eighty.review;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ReviewService {
	   List<ReviewVO> getReviewList(ReviewVO vo);
	   ReviewVO getReview(@Param("idx") int idx);
	   ReviewVO getReview2(@Param("idx") int idx);
	   double getAverageGrade(String productCode);
	   void insertReview(ReviewVO vo);
	   int getReviewCount(String productCode);
	   ReviewVO getOrderDetailByIdx(Long idx);
	   int delReview(@Param("idx") int idx);
}