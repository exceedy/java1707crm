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
import com.situ.crm.dao.CustomerLossMeasureMapper;
import com.situ.crm.pojo.CustomerLossMeasure;
import com.situ.crm.pojo.CustomerLossMeasureExample;
import com.situ.crm.pojo.CustomerLossMeasureExample.Criteria;
import com.situ.crm.service.ICustomerLossMeasureService;
import com.situ.crm.uitl.Util;

@Service
public class CustomerLossMeasureServiceImpl implements ICustomerLossMeasureService {

	@Autowired
	private CustomerLossMeasureMapper customerLossMeasureDao;
	
	public EasyUIDataGrid pageList(CustomerLossMeasure customerLossMeasure, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		CustomerLossMeasureExample example =  new CustomerLossMeasureExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		List<CustomerLossMeasure> customerLossMeasureList = customerLossMeasureDao.selectByExample(example);
		
		PageInfo<CustomerLossMeasure> pageInfo = new PageInfo<CustomerLossMeasure>(customerLossMeasureList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(customerLossMeasureList);
		
		return dataGrid;
	}

	public ServletResponse add(CustomerLossMeasure customerLossMeasure) {
		
		int result = customerLossMeasureDao.insert(customerLossMeasure);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += customerLossMeasureDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse update(CustomerLossMeasure customerLossMeasure) {
		int result = customerLossMeasureDao.updateByPrimaryKey(customerLossMeasure);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}
	
	public ServletResponse deleteById (Integer id) {
		int result = customerLossMeasureDao.deleteByPrimaryKey(id);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

}
