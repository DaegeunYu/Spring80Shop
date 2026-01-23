package com.eighty.log;

public class LogAdvice {
	
	LogAdvice(){
		System.out.println("==> LogAdvice 생성자");
	}
	
	public void beforeLog() {
		System.out.println("==> beforeLog 메소드");
	}
	
	public void afterLog() {
		System.out.println("==> afterLog 메소드");
	}
}
