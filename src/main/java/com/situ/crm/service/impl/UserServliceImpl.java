package com.situ.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.dao.UserMapper;
import com.situ.crm.pojo.User;
import com.situ.crm.pojo.UserExample;
import com.situ.crm.service.IUserService;

@Service
public class UserServliceImpl implements IUserService {
	
	@Autowired
	private UserMapper userDao;

	public EasyUIDataGrid pageList(Integer page, Integer rows) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		UserExample example = new UserExample();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		List<User> userList = userDao.selectByExample(example);
		//total
		PageInfo<User> pageInfo = new PageInfo<User>(userList);
		int total = (int)pageInfo.getTotal();
		dataGrid.setTotal(total);
		dataGrid.setRows(userList);
		return dataGrid;
	}

}
