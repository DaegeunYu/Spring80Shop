package com.eighty.review;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ReviewDao {
	   List<ReviewVO> getReviewList(ReviewVO vo);
	   ReviewVO getReview(@Param("idx") int idx);
	   ReviewVO getReview2(@Param("idx") int idx);
	   double getAverageGrade(String productCode);
	   void insertReview(ReviewVO vo);
	   int selectReviewCount(String productCode);
	   void updateReviewStatus(ReviewVO vo);
	   ReviewVO getOrderDetailByIdx(Long idx);
	   int delReview(@Param("idx") int idx);
}
