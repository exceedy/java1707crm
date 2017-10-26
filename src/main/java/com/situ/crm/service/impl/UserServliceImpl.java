package com.situ.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		List<User> userList = userDao.selectByExample(example);
		int total = userDao.countByExample(example);
		dataGrid.setTotal(total);
		dataGrid.setRows(userList);
		return dataGrid;
	}

}
