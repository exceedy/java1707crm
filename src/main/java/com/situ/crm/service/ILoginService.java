package com.situ.crm.service;

import javax.servlet.http.HttpServletRequest;

import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.User;

public interface ILoginService {

	ServletResponse login(User user, HttpServletRequest req);

}
