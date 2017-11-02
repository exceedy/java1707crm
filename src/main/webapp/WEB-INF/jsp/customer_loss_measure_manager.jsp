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
		$.post("${ctx}/customerLoss/findById.action", 
				{id : '${param.customerLossId}'}, 
				function(result) {
					if(result.status==Util.SUCCESS) {
						$("#customerNo").val(result.data.customerNo);
						$("#customerName").val(result.data.customerName);
						$("#customerManager").val(result.data.customerManager);
						$("#lastOrderTime").val(result.data.lastOrderTime);
					}
					
				}, 
				"json");
		
		/*展示数据的datagrid表格*/
		$("#datagrid").edatagrid({
			url:'${ctx}/customerLossMeasure/findAll.action?customerLossId=${param.customerLossId}',//只查询当前公司的暂缓措施
			saveUrl:'${ctx}/customerLossMeasure/add.action?customerLossId=${param.customerLossId}',
			updateUrl:'${ctx}/customerLossMeasure/update.action?customerLossId=${param.customerLossId}',
			destroyUrl:'${ctx}/customerLossMeasure/deleteById.action',
			method:'get',
			fit:true,
			singleSelect:false,
			toolbar:'#toolbar',
			rownumbers:true,
			fitColumns:true,
			pagination:true,
			columns:[[    
			      {field:'id',title:'编号',width:50,align:'center'},    
			     {field:'measure',title:'措施',width:100,align:'center',editor:{type:'validatebox',options:{required:true}}},    
			     ]]  
		});
	});
		//修改流失状态
		function updateCustomerLossStatus(status){
			 $.post("${ctx}/customerLoss/updateStatus.action",
					 {customerLossId:'${param.customerLossId}',status:status},
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
	<div id="p" class="easyui-panel" title="销售机会信息" style="width: 700px;height: 400px;padding: 10px">
	 	<table cellspacing="8px">
	   		<tr>
	   			<td>客户编号：</td>
	   			<td><input type="text" id="customerNo" name="customerNo" readonly="readonly"/></td>
	   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   			<td>客户名称</td>
	   			<td><input type="text" id="customerName" name="customerName" readonly="readonly"/></td>
	   		</tr>
	   		<tr>
	   			<td>客户经理：</td>
	   			<td><input type="text" id="customerManager" name="customerManager" readonly="readonly"/></td>
	   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   			<td>上次下单时间：</td>
	   			<td><input type="text" id="lastOrderTime" name="lastOrderTime" readonly="readonly"/></td>
	   		</tr>
	   	</table>
	 </div>
	 <!-- 营销机会信息面板  结束  -->
	 
	<!-- 客户开发计划项table -->
	<table id="datagrid"></table>
	
	<!-- toolbar 开始 -->
	 <div id="toolbar">
	 	<c:if test="${param.show!='true' }">
		 	<div>
		 	<a href="javascript:$('#datagrid').edatagrid('addRow')" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		 	<a href="javascript:$('#datagrid').edatagrid('destroyRow')" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		 	<a href="javascript:$('#datagrid').edatagrid('cancelRow')" class="easyui-linkbutton" iconCls="icon-undo" plain="true">撤销行</a>
		 	<a href="javascript:$('#datagrid').edatagrid('saveRow');$('#datagrid').edatagrid('reload')" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
		 	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-kfcg" plain="true" onclick="updateCustomerLossStatus(1)">开发成功</a>
		 	</div>
	 	</c:if>
	 </div>
	<!-- toolbar 结束 -->
	


</body>
</html>