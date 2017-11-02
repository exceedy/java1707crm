package com.situ.crm.service;

import java.util.Date;
import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.CustomerOrder;

public interface ICustomerOrderService {

	EasyUIDataGrid pageList(CustomerOrder customerOrder, Integer rows, Integer page, Date startTime, Date endTime);

	ServletResponse add(CustomerOrder customerOrder);

	ServletResponse delete(String ids);

	ServletResponse update(CustomerOrder customerOrder);

	ServletResponse deleteById(Integer id);


}
