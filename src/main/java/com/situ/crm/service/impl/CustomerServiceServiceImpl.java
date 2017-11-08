package com.situ.crm.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.util.StringUtil;
import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.dao.CustomerServiceMapper;
import com.situ.crm.pojo.CustomerService;
import com.situ.crm.pojo.CustomerServiceExample;
import com.situ.crm.pojo.CustomerServiceExample.Criteria;
import com.situ.crm.service.ICustomerServiceService;
import com.situ.crm.uitl.Util;
import com.situ.crm.vo.CustomerContribute;

@Service
public class CustomerServiceServiceImpl implements ICustomerServiceService {

	@Autowired
	private CustomerServiceMapper customerServiceDao;
	
	public EasyUIDataGrid pageList(CustomerService customerService, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		CustomerServiceExample example =  new CustomerServiceExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		if (StringUtil.isNotEmpty(customerService.getServiceType())) {
			createCriteria.andServiceTypeLike(Util.formatLike(customerService.getServiceType()));
		}
		if (StringUtil.isNotEmpty(customerService.getOverview())) {
			createCriteria.andOverviewLike(Util.formatLike(customerService.getOverview()));
		}
		if (StringUtil.isNotEmpty(customerService.getCustomer())) {
			createCriteria.andCustomerLike(Util.formatLike(customerService.getCustomer()));
		}
		if (StringUtil.isNotEmpty(customerService.getServiceType())) {
			createCriteria.andCreateTimeBetween(startTime, endTime);
		}
		List<CustomerService> customerServiceList = customerServiceDao.selectByExample(example);
		PageInfo<CustomerService> pageInfo = new PageInfo<CustomerService>(customerServiceList);
		int total = (int)pageInfo.getTotal();
		dataGrid.setTotal(total);
		dataGrid.setRows(customerServiceList);
		
		return dataGrid;
	}

	public ServletResponse add(CustomerService customerService) {
		
		int result = customerServiceDao.insert(customerService);
		if (result > 0) {
			return ServletResponse.creatSuccess("添加成功");
		}
		return ServletResponse.creatError("添加失败");
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += customerServiceDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess("删除成功");
		}
		return ServletResponse.creatError("删除失败");
	}

	public ServletResponse update(CustomerService customerService) {
		int result = customerServiceDao.updateByPrimaryKey(customerService);
		if (result > 0) {
			return ServletResponse.creatSuccess("修改成功");
		}
		return ServletResponse.creatError("修改失败");
	}

	public ServletResponse findById(Integer id) {
		
		CustomerService customerService = customerServiceDao.selectByPrimaryKey(id);
		if (customerService != null) {
			return ServletResponse.creatSuccess(customerService);
		}
		return ServletResponse.creatError();
	}

	public ServletResponse serviceAnalysis() {
		List<CustomerContribute> data = customerServiceDao.serviceAnalysis();
		for (CustomerContribute customerContribute : data) {
			System.out.println(customerContribute);
		}
		if (data != null) {
			return ServletResponse.creatSuccess(data);
		} 
		return ServletResponse.creatError();
	}



}
