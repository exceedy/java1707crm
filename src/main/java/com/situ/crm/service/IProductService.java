package com.situ.crm.service;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.Product;

public interface IProductService {

	EasyUIDataGrid pageList(Product product, Integer rows, Integer page);

	ServletResponse add(Product product);

	ServletResponse delete(String ids);

	ServletResponse update(Product product);

}
