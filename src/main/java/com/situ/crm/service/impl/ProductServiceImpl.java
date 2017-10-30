package com.situ.crm.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.dao.ProductMapper;
import com.situ.crm.pojo.Product;
import com.situ.crm.pojo.ProductExample;
import com.situ.crm.service.IProductService;
import com.situ.crm.uitl.Util;

@Service
public class ProductServiceImpl implements IProductService {

	private ProductMapper productDao;
	
	public EasyUIDataGrid pageList(Product product, Integer rows, Integer page) {
		EasyUIDataGrid dataGrid = new EasyUIDataGrid();
		
		ProductExample example =  new ProductExample();
		//配置分页
		PageHelper.startPage(page, rows);
		//执行查询
		if (StringUtils.isNotEmpty(product.getProductName())) {
			//查询的条件
			example.createCriteria().andProductNameLike(Util.formatLike(product.getProductName()));
		}
		List<Product> productList = productDao.selectByExample(example);
		
		PageInfo<Product> pageInfo = new PageInfo<Product>(productList);
		int total = (int)pageInfo.getTotal();
		
		dataGrid.setTotal(total);
		dataGrid.setRows(productList);
		
		return dataGrid;
	}

}
