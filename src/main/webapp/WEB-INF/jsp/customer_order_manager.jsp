<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx}/resources/thirdlib/jquery-easyui/jquery.edatagrid.js"></script>
<script type="text/javascript">
	$(function(){
		//查询指定id的销售机会
		$.post("${ctx}/customer/findById.action", 
				{id : '${param.customerId}'}, 
				function(result) {
					if(result.status==Util.SUCCESS) {
						$("#num").val(result.data.num);
						$("#name").val(result.data.name);
					}
					
				}, 
				"json");
		
		/*展示数据的datagrid表格*/
		$("#datagrid").edatagrid({
			url:'${ctx}/customerOrder/findAll.action?customerId=${param.customerId}',//只查询已分配咨询师的
			saveUrl:'${ctx}/customerOrder/add.action?customerId=${param.customerId}',
			updateUrl:'${ctx}/customerOrder/update.action?customerId=${param.customerId}',
			destroyUrl:'${ctx}/customerOrder/deleteById.action',
			method:'get',
			fit:true,
			singleSelect:false,
			rownumbers:true,
			fitColumns:true,
			pagination:true,
			columns:[[    
			      {field:'id',title:'编号',width:50,align:'center'},    
			     {field:'address',title:'订单号',width:80,align:'center'},    
			     {field:'time',title:'订单日期',width:80,align:'center'},    
			     {field:'overview',title:'送货地址',width:80,align:'center'},
			     {field:'overview',title:'状态',width:80,align:'center',
			    	formatter:function (value,row,index) {
			    		if (value == 0) {
			    			return '未回款';
			    		} else if (value == 1) {
			    			return '已回款';
			    		}
			    	}	 
			     },
			     {field:'a',title:'操作',width:80,align:'center',
			    	formatter:function (value,row,index) {
			    		return "<a href='javascript:openTab("+ row.id +")'>查看订单明细</a>"
			    	}	 
			     }
			     ]]  
		});
	});
		
		
		function openTab(customerOrderId) {
			window.parent.openTab("订单明细","${ctx}/customerOrderItems/index.anction?customerOrderId="+customerOrderId,'iocn-lsdd')
		}
		
		function updateSaleChanceDevResult(devResult){
			 $.post("${ctx}/saleChance/updateDevResult.action",
					 {customerId:'${param.customerId}',devResult:devResult},
					 function(result){
						 if(result.status == Util.SUCCESS){
							 $.messager.alert("系统提示",result.msg);
						 }else{
							 $.messager.alert("系统提示",result.msg);
						 }
			 		},
			 		"json");
		 }
</script>
</head>
<body>
	<!-- 营销机会信息面板  开始 -->
	<div id="p" class="easyui-panel" title="客户基本信息" style="width: 700px;height: 400px;padding: 10px">
	 	<table cellspacing="8px">
	   		<tr>
	   			<td>客户编号：</td>
	   			<td><input type="text" id="num" name="num" readonly="readonly"/></td>
	   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   			<td>客户名称：</td>
	   			<td><input type="text" id="name" name="name" readonly="readonly"/></td>
	   		</tr>
	   	</table>
	 </div>
	 <!-- 营销机会信息面板  结束  -->
	 
	<!-- 客户开发计划项table -->
	<table id="datagrid"></table>
	
	<!-- toolbar 开始 -->
	<!-- toolbar 结束 -->
	


</body>
</html>