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
import com.situ.crm.pojo.CustomerContact;
import com.situ.crm.service.ICustomerContactService;

@Controller
@RequestMapping(value="customerContact")
public class CustomerContactController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	@Autowired
	private ICustomerContactService cusDevPlaService;
	
	@RequestMapping(value="index")
	public String index () {
		return "customer_contact_manager";
	}
	
	
	
	@RequestMapping(value="findAll")
	@ResponseBody
	public EasyUIDataGrid findAll(Integer page, Integer rows,CustomerContact customerContact, Date startTime, Date endTime) {
		return cusDevPlaService.pageList(customerContact, rows, page, startTime, endTime);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(CustomerContact customerContact) {
		return cusDevPlaService.add(customerContact);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return cusDevPlaService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(CustomerContact customerContact) {
		return cusDevPlaService.update(customerContact);
	}
	
	@RequestMapping(value="deleteById")
	@ResponseBody
	public ServletResponse deleteById(Integer id) {
		return cusDevPlaService.deleteById(id);
	}
}
