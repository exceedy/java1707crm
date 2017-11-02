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
import com.situ.crm.dao.CusDevPlanMapper;
import com.situ.crm.pojo.CusDevPlan;
import com.situ.crm.pojo.CusDevPlanExample;
import com.situ.crm.pojo.CusDevPlanExample.Criteria;
import com.situ.crm.service.ICusDevPlanService;
import com.situ.crm.uitl.Util;

@Service
public class CusDevPlanServiceImpl implements ICusDevPlanService {

	@Autowired
	private CusDevPlanMapper cusDevPlanDao;
	
	public EasyUIDataGrid pageList(CusDevPlan cusDevPlan, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		CusDevPlanExample example =  new CusDevPlanExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		if (StringUtils.isNotEmpty(cusDevPlan.getExeAffect())) {
			//查询的条件
			createCriteria.andExeAffectLike(Util.formatLike(cusDevPlan.getExeAffect()));
		}
		if (cusDevPlan.getSaleChanceId() != null ) {
			//查询的条件
			createCriteria.andSaleChanceIdEqualTo(cusDevPlan.getSaleChanceId());
		}
		if (cusDevPlan.getPlanItem() != null) {
			createCriteria.andPlanItemLike(cusDevPlan.getPlanItem());
		}
		if (startTime != null && endTime != null) {
			createCriteria.andPlanDateBetween(startTime, endTime);
			
		} 
		List<CusDevPlan> cusDevPlanList = cusDevPlanDao.selectByExample(example);
		
		PageInfo<CusDevPlan> pageInfo = new PageInfo<CusDevPlan>(cusDevPlanList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(cusDevPlanList);
		
		return dataGrid;
	}

	public ServletResponse add(CusDevPlan cusDevPlan) {
		
		int result = cusDevPlanDao.insert(cusDevPlan);
		if (result > 0) {
			return ServletResponse.creatSuccess("添加成功");
		}
		return ServletResponse.creatError("添加失败");
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += cusDevPlanDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess("删除成功");
		}
		return ServletResponse.creatError("删除失败");
	}

	public ServletResponse update(CusDevPlan cusDevPlan) {
		int result = cusDevPlanDao.updateByPrimaryKey(cusDevPlan);
		if (result > 0) {
			return ServletResponse.creatSuccess("修改成功");
		}
		return ServletResponse.creatError("修改失败");
	}


}
