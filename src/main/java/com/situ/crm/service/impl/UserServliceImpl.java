package com.situ.crm.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.dao.UserMapper;
import com.situ.crm.pojo.User;
import com.situ.crm.pojo.UserExample;
import com.situ.crm.service.IUserService;
import com.situ.crm.uitl.Util;

@Service
public class UserServliceImpl implements IUserService {
	
	@Autowired
	private UserMapper userDao;

	public EasyUIDataGrid pageList(Integer page, Integer rows, User user) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		UserExample example = new UserExample();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		if (StringUtils.isNotEmpty(user.getName())) {
			example.createCriteria().andNameLike(Util.formatLike(user.getName()));
		}
		List<User> userList = userDao.selectByExample(example);
		//total
		PageInfo<User> pageInfo = new PageInfo<User>(userList);
		int total = (int)pageInfo.getTotal();
		dataGrid.setTotal(total);
		dataGrid.setRows(userList);
		return dataGrid;
	}

	public ServletResponse deleteUser(String ids) {
		String[] idStr = ids.split(",");
		try {
			for (String id : idStr) {
				userDao.deleteByPrimaryKey(Integer.parseInt(id));
			}
			return ServletResponse.creatSuccess("删除成功");
		} catch (Exception e) {
			return ServletResponse.creatError("删除失败");
		}
	}

	public ServletResponse addUser(User user) {
		try {
			int result = userDao.insert(user);
			if (result > 0) {
				return ServletResponse.creatSuccess("添加成功");
			} else {
				return ServletResponse.creatError("添加失败");
			}
			
		} catch (Exception e) {
			return ServletResponse.creatError("程序猿正在抢修");
		} 
	}

	public ServletResponse updateUser(User user) {
		if(userDao.updateByPrimaryKey(user) > 0) {
			return  ServletResponse.creatSuccess("修改成功");
		} 
		return ServletResponse.creatError("修改失败");
	}

}
