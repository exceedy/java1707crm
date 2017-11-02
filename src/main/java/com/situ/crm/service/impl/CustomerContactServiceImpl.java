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
import com.situ.crm.dao.CustomerContactMapper;
import com.situ.crm.pojo.CustomerContact;
import com.situ.crm.pojo.CustomerContactExample;
import com.situ.crm.pojo.CustomerContactExample.Criteria;
import com.situ.crm.service.ICustomerContactService;
import com.situ.crm.uitl.Util;

@Service
public class CustomerContactServiceImpl implements ICustomerContactService {

	@Autowired
	private CustomerContactMapper customerContactDao;
	
	public EasyUIDataGrid pageList(CustomerContact customerContact, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		CustomerContactExample example =  new CustomerContactExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		List<CustomerContact> customerContactList = customerContactDao.selectByExample(example);
		
		PageInfo<CustomerContact> pageInfo = new PageInfo<CustomerContact>(customerContactList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(customerContactList);
		
		return dataGrid;
	}

	public ServletResponse add(CustomerContact customerContact) {
		
		int result = customerContactDao.insert(customerContact);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += customerContactDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse update(CustomerContact customerContact) {
		int result = customerContactDao.updateByPrimaryKey(customerContact);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse deleteById(Integer id) {
		int result = customerContactDao.deleteByPrimaryKey(id);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}


}
