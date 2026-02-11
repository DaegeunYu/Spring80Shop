package com.eighty.product;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.eighty.shop.SQL_TYPE;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao  dao;
	
	@Override
	@Transactional
	public void insert(ProductVO vo, MultipartFile file) {
	    // 1. 번호 생성
	    String maxCode = dao.getMaxCode();
	    int nextNum = (maxCode == null) ? 1 : Integer.parseInt(maxCode) + 1;
	    String nextCode = String.format("%06d", nextNum);
	    vo.setProduct_code(nextCode);

	    // 2. 파일 이름 확정 (파일이 있을 경우에만 코드와 조합)
	    if (file != null && !file.isEmpty()) {
	        String originalName = file.getOriginalFilename();
	        String extension = originalName.substring(originalName.lastIndexOf("."));
	        String uuid = UUID.randomUUID().toString().substring(0, 4);
	        String saveName = nextCode + "_" + vo.getProduct_name() + "_" + uuid + extension;
	        
	        vo.setProduct_img("product/" + saveName);
	    }

	    // 3. 부모 상품 저장
	    dao.insert(vo);

	    // 4. 자식 옵션 저장
	    if (vo.getOptionList() != null) {
	        for (ProductVO.ProductOption option : vo.getOptionList()) {
	            option.setProduct_code(nextCode); // 생성된 코드로 연결
	            dao.insertOption(option);
	        }
	    }
	}

	@Override
	public List<ProductVO> getProductList(ProductVO vo, SQL_TYPE type) {
		return dao.getProductList(vo, type);
	}

	@Override
	public ProductVO getProduct(ProductVO vo) {
		return dao.getProduct(vo);
	}

	@Override
	public int count(ProductVO vo, SQL_TYPE type) {
		return dao.count(vo, type);
	}

	@Override
	public ProductVO getProductDetail(String productCode) {
		ProductVO vo = new ProductVO();
	    vo.setProduct_code(productCode);
	    return dao.getProduct(vo);
	}
	
	@Override
	public int getPrice(String product_code, String product_weight) {
		return dao.getPrice(product_code, product_weight);
	}
	
	@Override
	public int delProduct(@Param("idx") int idx) {
		return dao.delProduct(idx);
	}

	
	// LIKE
	@Override
	public void insert(LikeProductVO vo) {
		dao.insert(vo);
	}
	
	@Override
	public Long getLikeCount(LikeProductVO vo) {
		return dao.getLikeCount(vo);
	}

	@Override
	public List<ProductVO> getLikeProduct(LikeProductVO vo) {
		return dao.getLikeProduct(vo);
	}

	@Override
	public Short select(LikeProductVO vo) {
		return dao.select(vo);
	}

	@Override
	public void update(LikeProductVO vo) {
		dao.update(vo);
	}
}
