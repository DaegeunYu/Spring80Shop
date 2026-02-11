package com.eighty.review;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eighty.product.ProductDao;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDao  dao;
	
	@Autowired
    private ProductDao productDao;

	@Override
	public List<ReviewVO> getReviewList(ReviewVO vo) {
		return dao.getReviewList(vo);
	}

	@Override
	public ReviewVO getReview(@Param("idx") int idx) {
		return dao.getReview(idx);
	}

	@Override
	public double getAverageGrade(String productCode) {
		return dao.getAverageGrade(productCode);
	}

	@Override
	public void insertReview(ReviewVO vo) {
		dao.insertReview(vo);
        double avg = dao.getAverageGrade(vo.getProductCode());
        productDao.updateProductGrade(vo.getProductCode(), String.valueOf(avg));
        dao.updateReviewStatus(vo);
    }
	
	@Override
	public int getReviewCount(String productCode) {
	    return dao.selectReviewCount(productCode);
	}
}
