package com.situ.crm.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.dao.SaleChanceMapper;
import com.situ.crm.pojo.SaleChance;
import com.situ.crm.pojo.SaleChanceExample;
import com.situ.crm.pojo.SaleChanceExample.Criteria;
import com.situ.crm.service.ICusDevPlanService;
import com.situ.crm.uitl.Util;

@Service
public class CusDevPlanServiceImpl implements ICusDevPlanService {

	@Autowired
	private SaleChanceMapper saleChanceDao;
	
	public EasyUIDataGrid pageList(SaleChance saleChance, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		SaleChanceExample example =  new SaleChanceExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		if (StringUtils.isNotEmpty(saleChance.getLinkMan())) {
			//查询的条件
			createCriteria.andLinkManLike(Util.formatLike(saleChance.getLinkMan()));
		}
		if (StringUtils.isNotEmpty(saleChance.getOverview())) {
			//查询的条件
			createCriteria.andOverviewLike(Util.formatLike(saleChance.getOverview()));
		}
		if (StringUtils.isNotEmpty(saleChance.getCreateMan())) {
			//查询的条件
			createCriteria.andCreateManLike(Util.formatLike(saleChance.getCreateMan()));
		}
		if (saleChance.getStatus() != null) {
			createCriteria.andStatusEqualTo(saleChance.getStatus());
		}
		if (startTime != null && endTime != null) {
			createCriteria.andCreateTimeBetween(startTime, endTime);
			
		} 
		createCriteria.andStatusEqualTo(1);
		List<SaleChance> saleChanceList = saleChanceDao.selectByExample(example);
		
		PageInfo<SaleChance> pageInfo = new PageInfo<SaleChance>(saleChanceList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(saleChanceList);
		
		return dataGrid;
	}

	public ServletResponse add(SaleChance saleChance) {
		String assignMan = saleChance.getAssignMan();
		if (assignMan != null ) {//判断是否分配了指派人
			saleChance.setStatus(1);
			saleChance.setDevResult(1);
		} else {
			saleChance.setStatus(0);
			saleChance.setDevResult(0);
		}
		
		int result = saleChanceDao.insert(saleChance);
		if (result > 0) {
			return ServletResponse.creatSuccess("添加成功");
		}
		return ServletResponse.creatError("添加失败");
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += saleChanceDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess("删除成功");
		}
		return ServletResponse.creatError("删除失败");
	}

	public ServletResponse update(SaleChance saleChance) {
		int result = saleChanceDao.updateByPrimaryKey(saleChance);
		if (result > 0) {
			return ServletResponse.creatSuccess("修改成功");
		}
		return ServletResponse.creatError("修改失败");
	}


}
