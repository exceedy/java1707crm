package com.situ.crm.service;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.pojo.Product;

public interface IProductService {

	EasyUIDataGrid pageList(Product product, Integer rows, Integer page);

}
