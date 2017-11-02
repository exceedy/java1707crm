package com.situ.crm.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.dao.DataDicMapper;
import com.situ.crm.pojo.DataDic;
import com.situ.crm.pojo.DataDicExample;
import com.situ.crm.pojo.DataDicExample.Criteria;
import com.situ.crm.service.IDataDicService;
import com.situ.crm.uitl.Util;

@Service
public class DataDicServiceImpl implements IDataDicService {

	@Autowired
	private DataDicMapper dataDicDao;
	
	public EasyUIDataGrid pageList(DataDic dataDic, Integer rows, Integer page) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		DataDicExample example =  new DataDicExample();
		//配置分页
		PageHelper.startPage(page, rows);
		Criteria createCriteria = example.createCriteria();
		//执行查询
		if (StringUtils.isNotEmpty(dataDic.getDataDicName())) {
			//查询的条件
			createCriteria.andDataDicNameLike(Util.formatLike(dataDic.getDataDicName()));
		}
		if (StringUtils.isNotEmpty(dataDic.getDataDicValue())) {
			//查询的条件
			createCriteria.andDataDicValueLike(Util.formatLike(dataDic.getDataDicValue()));
		}
		List<DataDic> dataDicList = dataDicDao.selectByExample(example);
		
		PageInfo<DataDic> pageInfo = new PageInfo<DataDic>(dataDicList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(dataDicList);
		
		return dataGrid;
	}

	public ServletResponse add(DataDic dataDic) {
		int result = dataDicDao.insert(dataDic);
		if (result > 0) {
			return ServletResponse.creatSuccess("添加成功");
		}
		return ServletResponse.creatError("添加失败");
	}

	public ServletResponse delete(String ids) {
		String[] idStr = ids.split(",");
		int result = 0;
		for (String id : idStr) {
			 result += dataDicDao.deleteByPrimaryKey(Integer.parseInt(id));
		}
		if (result > 0) {
			return ServletResponse.creatSuccess("删除成功");
		}
		return ServletResponse.creatError("删除失败");
	}

	public ServletResponse update(DataDic dataDic) {
		int result = dataDicDao.updateByPrimaryKey(dataDic);
		if (result > 0) {
			return ServletResponse.creatSuccess("修改成功");
		}
		return ServletResponse.creatError("修改失败");
	}

	public List<DataDic> findDataDic() {
		return dataDicDao.findDataDic();
	}

	public List<DataDic> findByDataDicName() {
		return dataDicDao.findByDataDicName();
	}

}
