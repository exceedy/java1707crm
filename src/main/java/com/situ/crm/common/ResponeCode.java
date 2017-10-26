package com.situ.crm.common;

public enum ResponeCode {
	SUCCESS(0,"success"),
	ERROR(1,"error"),
	NEED_LOGIN(2,"need_login");
	
	private int code;
	private String desc;
	
	private ResponeCode(int code, String desc) {
		this.code = code;
		this.desc = desc;
	}

	public int getCode() {
		return code;
	}

	public String getDesc() {
		return desc;
	}
	
	
	
}
