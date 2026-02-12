package com.eighty.shop;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

public class ParameterValue {
	private String filePath = "/resources/files/";
	
	public String getFilePath() {
		return filePath;
	}
	
	public void deletePhysicalFile(String fileName, HttpServletRequest request) {
	    if (fileName == null || fileName.isEmpty()) return;

	    // 1. 실제 파일이 저장된 서버의 경로 찾기
	    // 보통 resources/files/ 경로에 저장하셨으니 해당 상대경로를 절대경로로 변환합니다.
	    String rootPath = request.getSession().getServletContext().getRealPath("/");
	    String savePath = rootPath + "resources" + File.separator + "files";
	    
	    // 2. 전체 파일 경로 생성
	    File file = new File(savePath + File.separator + fileName);

	    // 3. 파일 존재 여부 확인 후 삭제
	    if (file.exists()) {
	        if (file.delete()) {
	            System.out.println("파일 삭제 성공: " + fileName);
	        } else {
	            System.out.println("파일 삭제 실패: " + fileName);
	        }
	    } else {
	        System.out.println("삭제할 파일이 존재하지 않습니다: " + fileName);
	    }
	}
}
