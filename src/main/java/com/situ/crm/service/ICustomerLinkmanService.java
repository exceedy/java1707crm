package com.situ.crm.service;

import java.util.Date;
import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.CustomerLinkman;

public interface ICustomerLinkmanService {

	EasyUIDataGrid pageList(CustomerLinkman customerLinkman, Integer rows, Integer page, Date startTime, Date endTime);

	ServletResponse add(CustomerLinkman customerLinkman);

	ServletResponse delete(String ids);

	ServletResponse update(CustomerLinkman customerLinkman);

	ServletResponse deleteById(Integer id);


}
