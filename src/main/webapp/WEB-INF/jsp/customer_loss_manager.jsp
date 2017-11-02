<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../common/head.jsp" %>
</head>
 <script type="text/javascript">
 
 	$(function () {
 		$("#datagrid").datagrid({
 			url:'${ctx}/customerLoss/pageList.action',
 			rownumbers:true,
 			fitColumns:true,
 			pagination:true,
 			checkOnSelect:true,
 			fit:true,
 			toolbar:'#toolbar',
 			singleSelect:false,
 			method:'get',
 			columns:[[
 			        	{field:'cb',align:'center',checkbox:true},
 			        	{field:'id',align:'center',width:100,title:'编号'},
 			        	{field:'customerName',align:'center',width:100,title:'客户名称'},
 			        	{field:'customerManager',align:'center',width:100,title:'客户经理'},
 			        	{field:'lastOrderTime',align:'center',width:100,title:'上次下单日期'},
 			        	{field:'confirmLossTime  ',align:'center',width:100,title:'确认流失日期'},
 			        	{field:'status',align:'center',width:100,title:'客户状态', formatter:function (value,row,index) {
 			        		if (value == 0) {
 			        			return '暂缓流失';
 			        		} else if (value == 1) {
 			        			return '确认流失';
 			        		}
 			        	}},
 			        	{field:'a',align:'center',width:100, title:'操作',
 			        		formatter: function(value,row,index){
 			        			if (row.status == 0 ) {
 			        				return "<a href='javascript:openCusDevPlanTab("+ row.id +")'>暂缓流失</a>"
 			        			} else {
 			        				return "客户确认流失";
 			        			}
 			        		}}
 			        	
 			        	
 			     ]]
 		})
 		
 	})
 	
	 function remove() {
		var ids = Util.getSelectionsIds("#datagrid");
		if (ids.length == 0) {
			$.messager.layer("系统提示","请选择要删除的信息");
			return;
		}
		
		$.messager.layer("系统提示","确定要删除吗",function (r) {
			if (r) {
				$.post(
					"${ctx}/customerLoss/delete.action",
					{ids:ids},
					function (result) {
						if (result.status == Util.SUCCESS) {
							$.messager.layer(result.msg);
							$("#datagrid").datagrid('reload');
						} else {
							$.messager.layer(result.msg);
						}
					},
					"json"
				);
			}
		})
	} 
	 function doSearch () {
			$("#datagrid").datagrid("load",{
				'customerName':$('#customerName').val(),
				'customerManager':$("#customerManager").val(),
				'status':$('#status').val()
			})
		}
	 //指定分配人时的时间
	 $(function () {
		 $("#assignMan").combobox({
			 onClick:function () {
				 $("#assignTime").val(Util.getCurrentDateTime());
			 }
		 })
	 });
	 var url;
	 //添加弹出
	 function openAddDialog() {
		 $("#dialog").dialog("open").dialog("setTitle","添加");
		 $("#form").form("clear");
		 $("#createMan").val("${user.name}");
		 $("#createTime").val(Util.getCurrentDateTime());
		 url="$(ctx)/customerLoss/add.action"
	 }
	 //修改弹出
	 function openUpdateDialog() {
		 var selected = $("#datagrid").datagrid("getSelections");
		 if (selected.length == 0) {
			 $.messager.layer("系统提示","请选择要修改的信息");
			 return;
		 }
		 $("#dialog").dialog("open").dialog("setTitle","修改");
		 $("#form").form("load",selected[0]);
		 url = '${ctx}/customerLoss/update.action';
	 }
	 //修改和添加的提交
	 function doSave() {
		 $("#form").form("submit",{
			 url:url,
			 onSubmit: function () {
				 return $(this).form("validate");                                                                                                                                                                                                                                                                                                           
			 },
			   
			 success:function (result) {
				 var result = eval('('+ result +')');
				 if (result.status == Util.SUCCESS) {
					 $.messager.layer(result.msg);
					 $("#dialog").dialog("close");
					 $("#datagrid").datagrid("reload");
				 } else {
					 $.messager.layer(result.msg);
				 }
			 }
		 })
	 }
	 
	//可以修改添加开发项
		function openCusDevPlanTab(id){
			 window.parent.openTab('客户流失暂缓措施管理','${ctx}/customerLossMeasure/index.action?customerLossId='+id,'icon-khkfjh');
		}
		 
</script> 
<body>
	<!-- 数据表格 -->
		<table id="datagrid" ></table>
		
		<!-- 表格按钮 -->
		<div id="toolbar">
			<div>
				客户名称：<input type="text" id="customerName" style="width:100px"/>
				客户经理：<input type="text" id="customerManager" style="width:100px"/>
				客户状态： <select  class="easyui-combobox" id="status" >
							<option value="">请选择</option>
							<option value="1">确认流失</option>
							<option value="0">暂缓流失</option>
						</select>
						<a href="javascript:doSearch()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
			</div>
		 </div>
		 <div id="cc" class="easyui-calendar"></div>
		 
		
</body>
</html>