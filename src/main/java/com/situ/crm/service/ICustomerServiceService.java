package com.situ.crm.service;

import java.util.Date;
import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.CustomerService;

public interface ICustomerServiceService {

	EasyUIDataGrid pageList(CustomerService customerService, Integer rows, Integer page, Date startTime, Date endTime);

	ServletResponse add(CustomerService customerService);

	ServletResponse delete(String ids);

	ServletResponse update(CustomerService customerService);

	ServletResponse findById(Integer id);



}
