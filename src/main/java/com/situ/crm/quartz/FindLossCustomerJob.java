package com.situ.crm.quartz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.situ.crm.service.ICustomerService;

public class FindLossCustomerJob {
	
	@Autowired
	private ICustomerService customerService;
	
	@Scheduled(cron="0/30 0 0 * * ?")
	public void work() {
		System.out.println("sb");
		customerService.checkCustomerLoss();
	}
}
