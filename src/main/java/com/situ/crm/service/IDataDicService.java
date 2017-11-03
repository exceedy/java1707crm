package com.situ.crm.service;

import java.util.List;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.DataDic;

public interface IDataDicService {

	EasyUIDataGrid pageList(DataDic dataDic, Integer rows, Integer page);

	ServletResponse add(DataDic dataDic);

	ServletResponse delete(String ids);

	ServletResponse update(DataDic dataDic);

	List<DataDic> findDataDic();

	List<DataDic> findByDataDicName(String name);

}
