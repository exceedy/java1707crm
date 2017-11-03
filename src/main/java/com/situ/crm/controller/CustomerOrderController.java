package com.situ.crm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.CustomerOrder;
import com.situ.crm.service.ICustomerOrderService;

@Controller
@RequestMapping(value="customerOrder")
public class CustomerOrderController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	@Autowired
	private ICustomerOrderService cusDevPlaService;
	
	@RequestMapping(value="index")
	public String index () {
		return "customer_order_manager";
	}
	
	
	
	@RequestMapping(value="findAll")
	@ResponseBody
	public EasyUIDataGrid findAll(Integer page, Integer rows,CustomerOrder customerOrder, Date startTime, Date endTime) {
		return cusDevPlaService.pageList(customerOrder, rows, page, startTime, endTime);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(CustomerOrder customerOrder) {
		return cusDevPlaService.add(customerOrder);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return cusDevPlaService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(CustomerOrder customerOrder) {
		return cusDevPlaService.update(customerOrder);
	}
	
	@RequestMapping(value="deleteById")
	@ResponseBody
	public ServletResponse deleteById(Integer id) {
		return cusDevPlaService.deleteById(id);
	}
	@RequestMapping(value="findById")
	@ResponseBody
	public ServletResponse findByOrderId(Integer orderId) {
		return cusDevPlaService.findByOrederId(orderId);
	}
}
