package com.situ.crm.controller;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.situ.crm.common.EasyUIDataGrid;
import com.situ.crm.common.ServletResponse;
import com.situ.crm.pojo.SaleChance;
import com.situ.crm.service.ISaleChanceService;

@Controller
@RequestMapping(value="saleChance")
public class SaleChanceController {
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	@Autowired
	private ISaleChanceService saleChanceService;
	
	@RequestMapping(value="index")
	public String index () {
		return "sale_chance_manager";
	}
	
	@RequestMapping(value="cusDevPlan")
	public String cusDevPlan () {
		return "cus_dev_plan_manager";
	}
	
	
	@RequestMapping(value="pageList")
	@ResponseBody
	public EasyUIDataGrid pageList(Integer page, Integer rows,SaleChance saleChance, Date startTime, Date endTime) {
		return saleChanceService.pageList(saleChance, rows, page, startTime, endTime);
	}
	
	@RequestMapping(value="add")
	@ResponseBody
	public ServletResponse add(SaleChance saleChance) {
		return saleChanceService.add(saleChance);
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public ServletResponse delete(String ids) {
		return saleChanceService.delete(ids);
	}
	
	@RequestMapping(value="update")
	@ResponseBody
	public ServletResponse update(SaleChance saleChance) {
		return saleChanceService.update(saleChance);
	}
	
	@RequestMapping(value="findById")
	@ResponseBody
	public ServletResponse findById (Integer id) {
		return saleChanceService.findById(id);
	}
	@RequestMapping(value="updateDevResult")
	@ResponseBody
	public ServletResponse updateDevResult (Integer saleChanceId, Integer devResult) {
		return saleChanceService.updateDevResult(saleChanceId, devResult);
	}
	@RequestMapping("/exportExcel")
	public void exportExcel(HttpServletResponse response) {
		try {
			/*//1、查找用户列表
			List<SaleChance> list = saleChanceService.findAll();
			//2、导出
*/			response.setContentType("application/x-execl");
			response.setHeader("Content-Disposition", "attachment;filename=" + new String("用户列表.xls".getBytes(), "ISO-8859-1"));
			ServletOutputStream outputStream = response.getOutputStream();
			saleChanceService.exportExcel(outputStream);
			if(outputStream != null){
				outputStream.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="uploadExcel")
	@ResponseBody
	public ServletResponse uploadExcel(@RequestParam(value="uploadExcel") CommonsMultipartFile uploadExcel) {
		InputStream inputStream = null;
		Integer result = 0;
		try {
			inputStream = uploadExcel.getInputStream();
			SaleChance saleChance = new SaleChance();
			//1、读取工作薄。
			 		HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
			 		//2、读取工作表。
			 		HSSFSheet sheet = workbook.getSheetAt(0);
			 		//3、读取行
			 		String[] values = new String[8];
			 		for (int i = 0; i < 16; i++) {
			 			HSSFRow row = sheet.getRow(i+2);//第三行
			 			for (int y = 0; y < 8; y++) {
			 				//4、读取单元格
			 				HSSFCell cell = row.getCell(y);
			 				cell.setCellType(cell.CELL_TYPE_STRING);//值全部转换为string类型
			 				String value = cell.getStringCellValue();
			 				values[y] = value;
			 			}
			 			saleChance.setCustomerName(values[1]);
			 			saleChance.setOverview(values[2]);
			 			saleChance.setLinkMan(values[3]);
			 			saleChance.setLinkPhone(values[4]);
			 			saleChance.setCreateMan(values[5]);
			 			System.out.println(values[7]);
			 			if (values[7].equals("未分配")) {
			 				saleChance.setStatus(0);
			 			} else {
			 				saleChance.setStatus(1);
			 			}
			 			 if(saleChanceService.add(saleChance).status == 0) {
			 				 result += 1;
			 			 }
			 		}
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (inputStream != null) {
			try {
				inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (result == 0) {
			return ServletResponse.creatError("上传失败");
		} else {
			return ServletResponse.creatSuccess("上传成功");
		}
	}
}
