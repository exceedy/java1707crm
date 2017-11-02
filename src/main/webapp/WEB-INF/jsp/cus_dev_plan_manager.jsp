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
 			url:'${ctx}/saleChance/pageList.action?status=1',
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
 			        	{field:'overview',align:'center',width:100,title:'摘要'},
 			        	{field:'linkMan',align:'center',width:100,title:'联系人'},
 			        	{field:'createMan',align:'center',width:100,title:'创建人'},
 			        	{field:'createTime',align:'center',width:100,title:'创建时间'},
 			        	{field:'assignMan',align:'center',width:100,title:'指派人'},
 			        	{field:'assignTime',align:'center',width:100,title:'指派时间时间'},
 			        	{field:'devResult',align:'center',width:100, title:'状态',
 			        		formatter: function(value,row,index){
 			   				if (value == 0){
 			   					return '未开发';
 			   				} else if (value == 1) {
 			   					return '开发中';
 			   				} else if (value == 2) {
 			   					return '开发成功';
 			   				} else if (value == 3) {
 			   					return '开发失败';
 			   				}
 			   			}
 			        	},
 			        	{field:'a',align:'center',width:100, title:'操作',
 			        		formatter: function(value,row,index){
 			        			if (row.devResult == 0 || row.devResult == 1) {
 			        				return "<a href='javascript:openCusDevPlanTab("+ row.id +")'>开发</a>"
 			        			} else {
 			        				return "<a href='javascript:openCusDevPlanInfoTab("+ row.id +")'>查看详情信息</a>"
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
					"${ctx}/saleChance/delete.action",
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
				"customerName":$("#customerNameS").val(),
				"overview":$("#overview").val(),
				"createMan":$("#createManS").val(),
				"status":$("#status").val(),
				'startTime':$('#startTime').val(),
				"endTime":$('#endTime').val()
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
		 url="$(ctx)/saleChance/add.action"
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
		 url = '${ctx}/saleChance/update.action';
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
			 window.parent.openTab('客户开发计划项管理','${ctx}/cusDevPlan/index.action?saleChanceId='+id,'icon-khkfjh');
		}
		 
		//只能查看开发信息
		function openCusDevPlanInfoTab(id){
			window.parent.openTab('查看客户开发计划项','${ctx}/cusDevPlan/index.action?saleChanceId='+id+'&show=true','icon-khkfjh');
		}
</script> 
<body>
	<!-- 数据表格 -->
		<table id="datagrid" ></table>
		
		<!-- 表格按钮 -->
		<div id="toolbar">
			<div>
				客户名称：<input type="text" id="customerNameS" style="width:100px"/>
				摘要：<input type="text" id="overview" style="width:100px"/>
				创建人：<input type="text" id="createManS" style="width:100px"/>
				创建时间段：<input class="easyui-datebox" id="startTime" data-options="sharedCalendar:'#cc'">
					<input class="easyui-datebox" id="endTime" data-options="sharedCalendar:'#cc'">
				分配状态： <select  class="easyui-combobox" id="status" >
							<option value="">请选择</option>
							<option value="1">已分配</option>
							<option value="0">未分配</option>
						</select>
						<a href="javascript:doSearch()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
			</div>
		 </div>
		 <div id="cc" class="easyui-calendar"></div>
		 
		
</body>
</html>