package com.situ.crm.service;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.User;

public interface IUserService {

	EasyUIDataGrid pageList(Integer page, Integer rows, User user);

	ServletResponse deleteUser(String ids);

	ServletResponse addUser(User user);

	ServletResponse updateUser(User user);

	ServletResponse isUser(String userName);

	ServletResponse checkUserPassword(String name, String password);

	ServletResponse updatePassword(User user);

}
