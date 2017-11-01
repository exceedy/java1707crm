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
import com.situ.crm.pojo.SaleChance;
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
		return "cus_dev_plan_manager";
	}
	
	
	
	@RequestMapping(value="pageList")
	@ResponseBody
	public EasyUIDataGrid pageList(Integer page, Integer rows,SaleChance saleChance, Date startTime, Date endTime) {
		return cusDevPlaService.pageList(saleChance, rows, page, startTime, endTime);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(SaleChance saleChance) {
		return cusDevPlaService.add(saleChance);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return cusDevPlaService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(SaleChance saleChance) {
		return cusDevPlaService.update(saleChance);
	}
}
