package com.situ.crm.service;

import java.util.Date;
import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.SaleChance;

public interface ISaleChanceService {

	EasyUIDataGrid pageList(SaleChance saleChance, Integer rows, Integer page, Date startTime, Date endTime);

	ServletResponse add(SaleChance saleChance);

	ServletResponse delete(String ids);

	ServletResponse update(SaleChance saleChance);

	ServletResponse findById(Integer id);

	ServletResponse updateDevResult(Integer saleChanceId, Integer devResult);


}
