package com.situ.crm.service;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.pojo.User;

public interface IUserService {

	EasyUIDataGrid pageList(Integer page, Integer rows, User user);

}
