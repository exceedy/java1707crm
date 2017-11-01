package com.situ.crm.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.crm.common.ServletResponse;
import com.situ.crm.dao.UserMapper;
import com.situ.crm.pojo.User;
import com.situ.crm.pojo.UserExample;
import com.situ.crm.pojo.UserExample.Criteria;
import com.situ.crm.service.ILoginService;
import com.situ.crm.uitl.Util;

@Service
public class LoginServiceImpl implements ILoginService {

	@Autowired
	private UserMapper userDao;
	
	public ServletResponse login(User user, HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserExample example = new UserExample();
		Criteria createCriteria = example.createCriteria();
		if (StringUtils.isNotEmpty(user.getName())) {
			createCriteria.andNameEqualTo(user.getName());
		} 
		if (StringUtils.isNotEmpty(user.getPassword())) {
			createCriteria.andPasswordEqualTo(user.getPassword());
		}
		List<User> userList = userDao.selectByExample(example);
		if (userList != null || userList.size() != 0) {
			for (User resUser : userList) {
				if (resUser.getName().equals(user.getName()) && resUser.getPassword().equals(user.getPassword())) {
					session.setAttribute("currentUser", resUser);
					return ServletResponse.creatSuccess("登录成功");
				} else if (resUser.getName().equals(user.getName()) && !resUser.getPassword().equals(user.getPassword())) {
					return ServletResponse.creatError("密码错误");
				}
			}
		}
		return ServletResponse.creatError("登录失败");
	}

}
