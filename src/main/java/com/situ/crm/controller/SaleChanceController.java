package com.situ.crm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.SaleChance;
import com.situ.crm.service.ISaleChanceService;

@Controller
@RequestMapping(value="saleChance")
public class SaleChanceController {

	@Autowired
	private ISaleChanceService saleChanceService;
	
	@RequestMapping(value="index")
	public String index () {
		return "sale_chance_manager";
	}
	
	@RequestMapping(value="pageList")
	@ResponseBody
	public EasyUIDataGrid pageList(Integer page, Integer rows,SaleChance saleChance) {
		return saleChanceService.pageList(saleChance, rows, page);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(SaleChance saleChance) {
		return saleChanceService.add(saleChance);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return saleChanceService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(SaleChance saleChance) {
		return saleChanceService.update(saleChance);
	}
}
