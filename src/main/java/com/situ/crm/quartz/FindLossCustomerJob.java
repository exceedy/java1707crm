package com.situ.crm.quartz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.situ.crm.service.ICustomerService;

public class FindLossCustomerJob {
	
	@Autowired
	private ICustomerService customerService;
	
	@Scheduled(cron="0 0 2 * * ?")
	public void work() {
		customerService.checkCustomerLoss();
	}
}
