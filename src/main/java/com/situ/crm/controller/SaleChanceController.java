package com.situ.crm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

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
import com.situ.crm.service.ISaleChanceService;

@Controller
@RequestMapping(value="saleChance")
public class SaleChanceController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	@Autowired
	private ISaleChanceService saleChanceService;
	
	@RequestMapping(value="index")
	public String index () {
		return "sale_chance_manager";
	}
	
	@RequestMapping(value="cusDevPlan")
	public String cusDevPlan () {
		return "cus_dev_plan_manager";
	}
	
	
	@RequestMapping(value="pageList")
	@ResponseBody
	public EasyUIDataGrid pageList(Integer page, Integer rows,SaleChance saleChance, Date startTime, Date endTime) {
		return saleChanceService.pageList(saleChance, rows, page, startTime, endTime);
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
	
	@RequestMapping(value="findById")
	@ResponseBody
	public ServletResponse findById (Integer id) {
		return saleChanceService.findById(id);
	}
	@RequestMapping(value="updateDevResult")
	@ResponseBody
	public ServletResponse updateDevResult (Integer saleChanceId, Integer devResult) {
		return saleChanceService.updateDevResult(saleChanceId, devResult);
	}
	@RequestMapping("/exportExcel")
	public void exportExcel(HttpServletResponse response) {
		try {
			/*//1、查找用户列表
			List<SaleChance> list = saleChanceService.findAll();
			//2、导出
*/			response.setContentType("application/x-execl");
			response.setHeader("Content-Disposition", "attachment;filename=" + new String("用户列表.xls".getBytes(), "ISO-8859-1"));
			ServletOutputStream outputStream = response.getOutputStream();
			saleChanceService.exportExcel(outputStream);
			if(outputStream != null){
				outputStream.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
