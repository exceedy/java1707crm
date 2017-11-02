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
import com.situ.crm.pojo.CustomerLinkman;
import com.situ.crm.service.ICustomerLinkmanService;

@Controller
@RequestMapping(value="customerLinkman")
public class CustomerLinkmanController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	@Autowired
	private ICustomerLinkmanService cusDevPlaService;
	
	@RequestMapping(value="index")
	public String index () {
		return "customer_linkMan_manager";
	}
	
	
	
	@RequestMapping(value="findAll")
	@ResponseBody
	public EasyUIDataGrid findAll(Integer page, Integer rows,CustomerLinkman customerLinkman, Date startTime, Date endTime) {
		return cusDevPlaService.pageList(customerLinkman, rows, page, startTime, endTime);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(CustomerLinkman customerLinkman) {
		return cusDevPlaService.add(customerLinkman);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return cusDevPlaService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(CustomerLinkman customerLinkman) {
		return cusDevPlaService.update(customerLinkman);
	}
	
	@RequestMapping(value="deleteById")
	@ResponseBody
	public ServletResponse deleteById(Integer id) {
		return cusDevPlaService.deleteById(id);
	}
}
