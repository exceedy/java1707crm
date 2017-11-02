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
import com.situ.crm.pojo.CusDevPlan;
import com.situ.crm.service.ICusDevPlanService;

@Controller
@RequestMapping(value="cusDevPlan")
public class CusDevPlanController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	@Autowired
	private ICusDevPlanService cusDevPlaService;
	
	@RequestMapping(value="index")
	public String index () {
		return "cus_dev_plan_items_manager";
	}
	
	
	
	@RequestMapping(value="findAll")
	@ResponseBody
	public EasyUIDataGrid findAll(Integer page, Integer rows,CusDevPlan cusDevPlan, Date startTime, Date endTime) {
		return cusDevPlaService.pageList(cusDevPlan, rows, page, startTime, endTime);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(CusDevPlan cusDevPlan) {
		return cusDevPlaService.add(cusDevPlan);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return cusDevPlaService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(CusDevPlan cusDevPlan) {
		return cusDevPlaService.update(cusDevPlan);
	}
	
	@RequestMapping(value="deleteById")
	@ResponseBody
	public ServletResponse deleteById(Integer id) {
		return cusDevPlaService.deleteById(id);
	}
}
