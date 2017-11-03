package com.situ.crm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.DataDic;
import com.situ.crm.service.IDataDicService;

@Controller
@RequestMapping(value="dataDic")
public class DataDicController {

	@Autowired
	private IDataDicService dataDicService;
	
	@RequestMapping(value="index")
	public String index () {
		return "data_dic_manager";
	}
	
	@RequestMapping(value="pageList")
	@ResponseBody
	public EasyUIDataGrid pageList(Integer page, Integer rows,DataDic dataDic) {
		return dataDicService.pageList(dataDic, rows, page);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(DataDic dataDic) {
		return dataDicService.add(dataDic);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return dataDicService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(DataDic dataDic) {
		return dataDicService.update(dataDic);
	}
	
	@RequestMapping(value="findDataDicName")
	@ResponseBody
	public List<DataDic> findDataDic () {
		return dataDicService.findDataDic();
	}
	@RequestMapping(value="findByDataDicName")
	@ResponseBody
	public List<DataDic> findByDataDicName (String name) {
		return dataDicService.findByDataDicName(name);
	}
	
}
