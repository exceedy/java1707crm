package com.situ.crm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.User;
import com.situ.crm.service.IUserService;

@Controller
@RequestMapping(value="user")
public class UserController {
	
	@Autowired
	private IUserService userService;
	
	@RequestMapping(value="index")
	public String index () {
		return "user_manager";
	}
	
	@RequestMapping(value="pageList")
	@ResponseBody
	public EasyUIDataGrid pageList(Integer page, Integer rows, User user) {
		return userService.pageList(page, rows,user);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse deleteUser(String ids) {
		return userService.deleteUser(ids);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse addUser (User user) {
		return userService.addUser(user);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse updateUser (User user) {
		return userService.updateUser(user);
	}
}
