package com.situ.crm.vo;

public class CustomerContribute {
	//客户的名字
	private String name;
	
	//客户订单的总价格
	private long total;

	private Integer value;
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}

	

	public Integer getValue() {
		return value;
	}


	public void setValue(Integer value) {
		this.value = value;
	}


	public long getTotal() {
		return total;
	}



	public void setTotal(long total) {
		this.total = total;
	}



	@Override
	public String toString() {
		return "CustomerContribute [name=" + name + ", total=" + total + ", value=" + value + "]";
	}
	
	
}
