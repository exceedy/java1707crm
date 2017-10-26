package com.situ.crm.common;

import java.io.Serializable;

public class  ServletResponse<T> implements Serializable {
	public Integer status;
	public String msg;
	public T data;
	
	//告诉前台成功状态
		public static <T> ServletResponse<T> creatSuccess() {
			return new ServletResponse<T>(ResponeCode.SUCCESS.getCode());
		}
		//告诉前台成功状态和信息
		public static <T> ServletResponse<T> creatSuccess(String msg) {
			return new ServletResponse<T>(ResponeCode.SUCCESS.getCode(),msg);
		}
		//告诉前台成功状态、信息、和数据
		public static <T> ServletResponse<T> creatSuccess(String msg, T data) {
			return new ServletResponse<T>(ResponeCode.SUCCESS.getCode(),msg,data); 
		}
		//告诉前台更改状态和数据
		public static <T> ServletResponse<T> creatSuccess( T data) {
			return new ServletResponse<T>(ResponeCode.SUCCESS.getCode(),data); 
		}
		
		//告诉前台失败的状态
		public static <T> ServletResponse<T> creatError() {
			return new ServletResponse<T>(ResponeCode.ERROR.getCode());
		}
		//告诉前台失败的状态和信息
		public static <T> ServletResponse<T> creatError(String msg) {
			return new ServletResponse<T>(ResponeCode.ERROR.getCode(),msg);
		}
		//告诉前台失败的状态、信息、和数据
		public static <T> ServletResponse<T> creatError(String msg, T data) {
			return new ServletResponse<T>(ResponeCode.ERROR.getCode(),msg,data); 
		}
		//告诉前台失败的状态和数据
		public static <T> ServletResponse<T> creatError( T data) {
			return new ServletResponse<T>(ResponeCode.ERROR.getCode(),data); 
		}
		public ServletResponse() {
			super();
		}



		public ServletResponse(Integer status) {
			super();
			this.status = status;
		}



		public ServletResponse(Integer status, T data) {
			super();
			this.status = status;
			this.data = data;
		}



		public ServletResponse(Integer status, String msg) {
			super();
			this.status = status;
			this.msg = msg;
		}



		public ServletResponse(Integer status, String msg, T data) {
			super();
			this.status = status;
			this.msg = msg;
			this.data = data;
		}



		public Integer getStatus() {
			return status;
		}



		public void setStatus(Integer status) {
			this.status = status;
		}



		public String getMsg() {
			return msg;
		}



		public void setMsg(String msg) {
			this.msg = msg;
		}



		public T getData() {
			return data;
		}



		public void setData(T data) {
			this.data = data;
		}



		@Override
		public String toString() {
			return "ServletRespone [status=" + status + ", msg=" + msg + ", data=" + data + "]";
		}

		
		
}
