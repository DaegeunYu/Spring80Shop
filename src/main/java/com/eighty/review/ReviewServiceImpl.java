package com.eighty.review;

import java.util.List;

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
	public ReviewVO getReview(ReviewVO vo) {
		return dao.getReview(vo);
	}

	@Override
	public double getAverageGrade(String product_code) {
		return dao.getAverageGrade(product_code);
	}

	@Override
	public void insertReview(ReviewVO vo) {
		dao.insertReview(vo);
        double avg = dao.getAverageGrade(vo.getProduct_code());
        productDao.updateProductGrade(vo.getProduct_code(), String.valueOf(avg));
    }
	
	@Override
	public int getReviewCount(String product_code) {
	    return dao.selectReviewCount(product_code);
	}
}
