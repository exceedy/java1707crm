package com.situ.crm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.pojo.Product;
import com.situ.crm.service.IProductService;

@Controller
@RequestMapping(value="product")
public class ProductController {

	private IProductService productService;
	
	@RequestMapping(value="pageList")
	public EasyUIDataGrid pageList(Product product, Integer rows, Integer page) {
		return productService.pageList(product, rows, page);
	}
}
