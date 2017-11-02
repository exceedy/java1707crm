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
import com.situ.crm.dao.CustomerLinkmanMapper;
import com.situ.crm.pojo.CustomerLinkman;
import com.situ.crm.pojo.CustomerLinkmanExample;
import com.situ.crm.pojo.CustomerLinkmanExample.Criteria;
import com.situ.crm.service.ICustomerLinkmanService;
import com.situ.crm.uitl.Util;

@Service
public class CustomerLinkmanServiceImpl implements ICustomerLinkmanService {

	@Autowired
	private CustomerLinkmanMapper customerLinkmanDao;
	
	public EasyUIDataGrid pageList(CustomerLinkman customerLinkman, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		CustomerLinkmanExample example =  new CustomerLinkmanExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		List<CustomerLinkman> customerLinkmanList = customerLinkmanDao.selectByExample(example);
		
		PageInfo<CustomerLinkman> pageInfo = new PageInfo<CustomerLinkman>(customerLinkmanList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(customerLinkmanList);
		
		return dataGrid;
	}

	public ServletResponse add(CustomerLinkman customerLinkman) {
		
		int result = customerLinkmanDao.insert(customerLinkman);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += customerLinkmanDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse update(CustomerLinkman customerLinkman) {
		int result = customerLinkmanDao.updateByPrimaryKey(customerLinkman);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse deleteById(Integer id) {
		int result = customerLinkmanDao.deleteByPrimaryKey(id);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}


}
