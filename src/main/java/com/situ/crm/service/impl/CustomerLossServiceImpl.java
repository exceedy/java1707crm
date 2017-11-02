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
import com.situ.crm.dao.CustomerLossMapper;
import com.situ.crm.pojo.CustomerLoss;
import com.situ.crm.pojo.CustomerLossExample;
import com.situ.crm.pojo.CustomerLossExample.Criteria;
import com.situ.crm.service.ICustomerLossService;
import com.situ.crm.uitl.Util;

@Service
public class CustomerLossServiceImpl implements ICustomerLossService {

	@Autowired
	private CustomerLossMapper customerLossDao;
	
	public EasyUIDataGrid pageList(CustomerLoss customerLoss, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		CustomerLossExample example =  new CustomerLossExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		if (StringUtils.isNotEmpty(customerLoss.getCustomerName())) {
			//查询的条件
			createCriteria.andCustomerNameLike(Util.formatLike(customerLoss.getCustomerName()));
		}
		if (StringUtils.isNotEmpty(customerLoss.getCustomerManager())) {
			//查询的条件
			createCriteria.andCustomerManagerLike(Util.formatLike(customerLoss.getCustomerManager()));
		}
		
		if (customerLoss.getStatus() != null) {
			createCriteria.andStatusEqualTo(customerLoss.getStatus());
		}
		List<CustomerLoss> customerLossList = customerLossDao.selectByExample(example);
		
		PageInfo<CustomerLoss> pageInfo = new PageInfo<CustomerLoss>(customerLossList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(customerLossList);
		
		return dataGrid;
	}

	public ServletResponse add(CustomerLoss customerLoss) {
		
		int result = customerLossDao.insert(customerLoss);
		if (result > 0) {
			return ServletResponse.creatSuccess("添加成功");
		}
		return ServletResponse.creatError("添加失败");
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += customerLossDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess("删除成功");
		}
		return ServletResponse.creatError("删除失败");
	}

	public ServletResponse update(CustomerLoss customerLoss) {
		int result = customerLossDao.updateByPrimaryKey(customerLoss);
		if (result > 0) {
			return ServletResponse.creatSuccess("修改成功");
		}
		return ServletResponse.creatError("修改失败");
	}

	public ServletResponse findById(Integer id) {
		CustomerLoss data = customerLossDao.findById(id);
		if (data != null) {
			return ServletResponse.creatSuccess(data);
		}
		return ServletResponse.creatError();
	}





}
