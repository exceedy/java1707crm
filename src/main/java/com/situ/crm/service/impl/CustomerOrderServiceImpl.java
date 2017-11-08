package com.situ.crm.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.dao.CustomerOrderMapper;
import com.situ.crm.dao.OrderItemMapper;
import com.situ.crm.pojo.CustomerOrder;
import com.situ.crm.pojo.CustomerOrderExample;
import com.situ.crm.pojo.CustomerOrderExample.Criteria;
import com.situ.crm.pojo.OrderItem;
import com.situ.crm.service.ICustomerOrderService;

@Service
public class CustomerOrderServiceImpl implements ICustomerOrderService {

	@Autowired
	private CustomerOrderMapper customerOrderDao;
	@Autowired
	private OrderItemMapper orderItemDao;
	
	public EasyUIDataGrid pageList(CustomerOrder customerOrder, Integer rows, Integer page, Date startTime, Date endTime) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		CustomerOrderExample example =  new CustomerOrderExample();
		Criteria createCriteria = example.createCriteria();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		List<CustomerOrder> customerOrderList = customerOrderDao.selectByExample(example);
		
		PageInfo<CustomerOrder> pageInfo = new PageInfo<CustomerOrder>(customerOrderList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(customerOrderList);
		
		return dataGrid;
	}

	public ServletResponse add(CustomerOrder customerOrder) {
		
		int result = customerOrderDao.insert(customerOrder);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += customerOrderDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse update(CustomerOrder customerOrder) {
		int result = customerOrderDao.updateByPrimaryKey(customerOrder);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse deleteById(Integer id) {
		int result = customerOrderDao.deleteByPrimaryKey(id);
		if (result > 0) {
			return ServletResponse.creatSuccess();
		}
		return ServletResponse.creatError();
	}

	public ServletResponse findByOrederId(Integer orderId) {
		List<OrderItem> data = orderItemDao.findByOrderId(orderId);
		if (data != null) {
			return ServletResponse.creatSuccess(data);
		}
		return ServletResponse.creatError("无效订单");
	}


}
