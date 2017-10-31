package com.situ.crm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.User;
import com.situ.crm.service.ILoginService;

@Controller
@RequestMapping(value="login")
public class LoginController {

	@Autowired
	private ILoginService loginService;
	
	@RequestMapping(value="login")
	@ResponseBody
	public ServletResponse login (User user, HttpServletRequest req) {
		return loginService.login(user,req);
	}
	
	@RequestMapping(value="index")
	public String index () {
		return "redirect:/index/index.action";
	}
	
	@RequestMapping(value="toLogin")
	public String toLogin () {
		return "login";
	}
	
}
