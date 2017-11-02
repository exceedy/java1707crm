package com.situ.crm.service;

import java.util.Date;
import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.CustomerLossMeasure;

public interface ICustomerLossMeasureService {

	EasyUIDataGrid pageList(CustomerLossMeasure customerLossMeasure, Integer rows, Integer page, Date startTime, Date endTime);

	ServletResponse add(CustomerLossMeasure customerLossMeasure);

	ServletResponse delete(String ids);

	ServletResponse update(CustomerLossMeasure customerLossMeasure);


}
