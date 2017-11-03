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
import com.situ.crm.dao.CustomerMapper;
import com.situ.crm.dao.CustomerOrderMapper;
import com.situ.crm.pojo.Customer;
import com.situ.crm.pojo.CustomerExample;
import com.situ.crm.pojo.CustomerExample.Criteria;
import com.situ.crm.pojo.CustomerLoss;
import com.situ.crm.pojo.CustomerOrder;
import com.situ.crm.service.ICustomerService;
import com.situ.crm.uitl.Util;

@Service
public class CustomerServiceImpl implements ICustomerService {

	@Autowired
	private CustomerMapper customerDao;
	@Autowired
	private CustomerOrderMapper customerOrderDao;
	
	@Autowired
	private CustomerLossMapper customerLossDao;
	
	public EasyUIDataGrid pageList(Customer customer, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		CustomerExample example =  new CustomerExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		if (StringUtils.isNotEmpty(customer.getNum())) {
			//查询的条件
			createCriteria.andNumEqualTo(Util.formatLike(customer.getNum()));
		}
		if (StringUtils.isNotEmpty(customer.getName())) {
			//查询的条件
			createCriteria.andNameLike(Util.formatLike(customer.getName()));
		}
		List<Customer> customerList = customerDao.selectByExample(example);
		
		PageInfo<Customer> pageInfo = new PageInfo<Customer>(customerList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(customerList);
		
		return dataGrid;
	}

	public ServletResponse add(Customer customer) {
		
		int result = customerDao.insert(customer);
		if (result > 0) {
			return ServletResponse.creatSuccess("添加成功");
		}
		return ServletResponse.creatError("添加失败");
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += customerDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess("删除成功");
		}
		return ServletResponse.creatError("删除失败");
	}

	public ServletResponse update(Customer customer) {
		int result = customerDao.updateByPrimaryKey(customer);
		if (result > 0) {
			return ServletResponse.creatSuccess("修改成功");
		}
		return ServletResponse.creatError("修改失败");
	}

	public ServletResponse findById(Integer id) {
		Customer data = customerDao.selectByPrimaryKey(id);
		if (data != null) {
			return ServletResponse.creatSuccess(data);
		}
		return ServletResponse.creatError();
	}

	public void checkCustomerLoss() {
		//查找流失的客户
		List<Customer> customerList = customerDao.checkCustomerLoss();
		
		for (Customer customer : customerList) {
			CustomerLoss customerLoss = new CustomerLoss();
			customerLoss.setCustomerNo(customer.getNum());//客户编号
			customerLoss.setCustomerName(customer.getName());//客户名称
			//查询最后一次订单时间
			customerLoss.setCustomerManager(customer.getManagerName());//客户经理
			
			CustomerOrder customerOrder = customerOrderDao.findLastOrderByCustomerId(customer.getId());
			
			if (customerOrder == null) {
				customerLoss.setLastOrderTime(null);
			} else {
				customerLoss.setLastOrderTime(customerOrder.getOrderDate());
			}
			//添加到流失表
			customerLossDao.insert(customerLoss);
			
			customer.setStatus(1);
			customerDao.updateByPrimaryKeySelective(customer);
		}
	}





}
