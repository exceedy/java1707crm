package com.situ.crm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="index")
public class IndexController {
	
	@RequestMapping(value="index")
	public String index() {
		return "index";
	}
}
