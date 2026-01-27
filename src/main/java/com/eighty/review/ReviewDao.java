package com.eighty.review;

import java.util.List;

public interface ReviewDao {
   List<ReviewVO> getReviewList(ReviewVO vo);
   ReviewVO getReview(ReviewVO vo);
}
