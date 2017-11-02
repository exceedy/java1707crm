package com.situ.crm.service;

import java.util.Date;
import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.CustomerLoss;

public interface ICustomerLossService {

	EasyUIDataGrid pageList(CustomerLoss customerLoss, Integer rows, Integer page, Date startTime, Date endTime);

	ServletResponse add(CustomerLoss customerLoss);

	ServletResponse delete(String ids);

	ServletResponse update(CustomerLoss customerLoss);

	ServletResponse findById(Integer id);




}
