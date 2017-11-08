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
import com.situ.crm.pojo.Customer;
import com.situ.crm.service.ICustomerService;
import com.situ.crm.vo.CustomerContribute;

@Controller
@RequestMapping(value="customer")
public class CustomerController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	@Autowired
	private ICustomerService customerService;
	
	@RequestMapping(value="index")
	public String index () {
		return "customer_manager";
	}
	@RequestMapping(value="getCustomerContribute")
	public String getCustomerContribute () {
		return "customerContribute_manager";
	}
	
	@RequestMapping(value="findCustomerContribute")
	@ResponseBody
	public EasyUIDataGrid findCustomerContribute(Integer page, Integer rows, CustomerContribute customerContribute) {
		return customerService.findCustomerContribute(page,rows,customerContribute);
	}
	
	@RequestMapping(value="composition")
	@ResponseBody
	public ServletResponse composition () {
		 return customerService.composition();
	}
	@RequestMapping(value="getComposition")
	public String getComposition () {
		return "customer_composition_analysis";
	}
	
	@RequestMapping(value="pageList")
	@ResponseBody
	public EasyUIDataGrid pageList(Integer page, Integer rows,Customer customer, Date startTime, Date endTime) {
		return customerService.pageList(customer, rows, page, startTime, endTime);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(Customer customer) {
		return customerService.add(customer);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return customerService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(Customer customer) {
		return customerService.update(customer);
	}
	
	@RequestMapping(value="findById")
	@ResponseBody
	public ServletResponse findById(Integer id) {
		return customerService.findById(id);
	}
	
}
