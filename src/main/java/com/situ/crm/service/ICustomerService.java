package com.situ.crm.service;

import java.util.Date;
import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.Customer;

public interface ICustomerService {

	EasyUIDataGrid pageList(Customer customer, Integer rows, Integer page, Date startTime, Date endTime);

	ServletResponse add(Customer customer);

	ServletResponse delete(String ids);

	ServletResponse update(Customer customer);

	ServletResponse findById(Integer id);

	void checkCustomerLoss();




}
