package com.situ.crm.service;

import java.util.Date;
import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.CusDevPlan;

public interface ICusDevPlanService {

	EasyUIDataGrid pageList(CusDevPlan cusDevPlan, Integer rows, Integer page, Date startTime, Date endTime);

	ServletResponse add(CusDevPlan cusDevPlan);

	ServletResponse delete(String ids);

	ServletResponse update(CusDevPlan cusDevPlan);


}
