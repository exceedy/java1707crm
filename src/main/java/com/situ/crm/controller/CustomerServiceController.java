package com.situ.crm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.CustomerService;
import com.situ.crm.service.ICustomerServiceService;

@Controller
@RequestMapping(value="customerService")
public class CustomerServiceController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	@Autowired
	private ICustomerServiceService customerServiceService;
	
	@RequestMapping(value="addIndex")
	public String addIndex () {
		return "customer_service_add_manager";
	}
	
	@RequestMapping(value="assignerIndex")
	public String assignerIndex () {
		return "customer_service_assigner_manager";
	}
	@RequestMapping(value="dealIndex")
	public String dealIndex () {
		return "customer_service_deal_manager";
	}
	@RequestMapping(value="dealResultIndex")
	public String dealResultIndex () {
		return "customer_service_deal_result_manager";
	}
	@RequestMapping(value="index")
	public String index () {
		return "customer_service_manager";
	}
	
	
	@RequestMapping(value="pageList")
	@ResponseBody
	public EasyUIDataGrid pageList(Integer page, Integer rows,CustomerService customerService, Date startTime, Date endTime) {
		return customerServiceService.pageList(customerService, rows, page, startTime, endTime);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(CustomerService customerService) {
		return customerServiceService.add(customerService);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return customerServiceService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(CustomerService customerService) {
		return customerServiceService.update(customerService);
	}
	
	@RequestMapping(value="findById")
	@ResponseBody
	public ServletResponse findById (Integer id) {
		return customerServiceService.findById(id);
	}
	
}
