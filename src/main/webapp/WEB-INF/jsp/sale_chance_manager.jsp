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
 			url:'${ctx}/saleChance/pageList.action',
 			rownumbers:true,
 			fitColumns:true,
 			pagination:true,
 			checkOnSelect:true,
 			fit:true,
 			singleSelect:false,
 			method:'get',
 			toolbar:'#toolbar',
 			columns:[[
 			        	{field:'cb',align:'center',checkbox:true},
 			        	{field:'id',align:'center',width:100,title:'编号'},
 			        	{field:'customerName',align:'center',width:100,title:'客户名称'},
 			        	{field:'overview',align:'center',width:100,title:'摘要'},
 			        	{field:'linkMan',align:'center',width:100,title:'联系人'},
 			        	{field:'linkPhone',align:'center',width:100,title:'联系方式'},
 			        	{field:'createMan',align:'center',width:100,title:'创建人'},
 			        	{field:'createTime',align:'center',width:100,title:'创建时间'},
 			        	{field:'status',align:'center',width:100, title:'状态',
 			        		formatter: function(value,row,index){
 			   				if (value == 1){
 			   					return '已分配';
 			   				} else  {
 			   					return '未分配';
 			   				}
 			   			}
 			        	}
 			        	
 			        	
 			     ]]
 		})
 		
 	})
 	//对话框
 	$(function () {
 		$("#dialog").dialog({
 			
 			closed:true,
 			closable:true,
 			buttons:[
 			 	{
 			 		text:'保存',
 			 		iconCls:'icon-ok',
 			 		handler:function () {
 			 			doSave();
 			 		}
 			 	},
 			 	{
 			 		text:'关闭',
 			 		iconCls:'icon-remove',
 			 		handler:function () {
 			 			$("#dialog").dialog("close");
 			 		}
 			 	}
 			 ]
 		});
 	});
	 function remove() {
		var ids = Util.getSelectionsIds("#datagrid");
		if (ids.length == 0) {
			$.messager.alert("系统提示","请选择要删除的信息");
			return;
		}
		
		$.messager.alert("系统提示","确定要删除吗",function (r) {
			if (r) {
				$.post(
					"${ctx}/saleChance/delete.action",
					{ids:ids},
					function (result) {
						if (result.status == Util.SUCCESS) {
							$.messager.alert(result.msg);
							$("#datagrid").datagrid('reload');
						} else {
							$.messager.alert(result.msg);
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
		 $("#createMan").val("${currentUser.name}");
		 $("#createTime").val(Util.getCurrentDateTime());
		 url="${ctx}/saleChance/add.action"
	 }
	 //修改弹出
	 function openUpdateDialog() {
		 var selected = $("#datagrid").datagrid("getSelections");
		 if (selected.length == 0) {
			 $.messager.alert("系统提示","请选择要修改的信息");
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
					 $.messager.alert(result.msg);
					 $("#dialog").dialog("close");
					 $("#datagrid").datagrid("reload");
				 } else {
					 $.messager.alert(result.msg);
				 }
			 }
		 })
	 }
</script> 
<body>
	<!-- 数据表格 -->
		<table id="datagrid" ></table>
		
		<!-- 表格按钮 -->
		<div id="toolbar">
			<div>
				 <a href="javascript:openAddDialog()" class="easyui-linkbutton" iconCls="icon-add" >添加</a>
				<a href="javascript:openUpdateDialog()" class="easyui-linkbutton" iconCls="icon-edit" >修改</a>
				<a href="javascript:remove()" class="easyui-linkbutton" iconCls="icon-remove" >删除</a>
			</div>
			<div>
				客户名称：<input type="text" id="customerNameS" style="width:100px"/>
				摘要：<input type="text" id="overview" style="width:100px"/>
				创建人：<input type="text" id="createManS"  style="width:100px"/>
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
		 
		<!-- 添加和修改的dialog 开始 -->
	<div id="dialog" modal="true" style="width:650;height:280,padding: 10px 20px">
		<form action="" id="form" method="post">
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
		   		<tr>
		   			<td>客户名称：</td>
		   			<td><input type="text" id="customerName" name="customerName" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>机会来源</td>
		   			<td><input type="text" id="chanceSource" name="chanceSource" /></td>
		   		</tr>
		   		<tr>
		   			<td>联系人：</td>
		   			<td><input type="text" id="linkMan" name="linkMan" /></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>联系电话：</td>
		   			<td><input type="text" id="linkPhone" name="linkPhone" /></td>
		   		</tr>
		   		<tr>
		   			<td>成功几率(%)：</td>
		   			<td><input type="text" id="successRate" name="successRate" class="easyui-numberbox" data-options="min:0,max:100" required="true"/>&nbsp;<font color="red">*</font></td>
		   			<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   		</tr>
		   		<tr>
		   			<td>概要：</td>
		   			<td colspan="4"><input type="text" id="overview" name="overview" style="width: 420px"/></td>
		   		</tr>
		   		<tr>
		   			<td>机会描述：</td>
		   			<td colspan="4">
		   				<textarea rows="5" cols="50" id="description" name="description"></textarea>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>创建人：</td>
		   			<td><input type="text" readonly="true" id="createMan" name="createMan"  />&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>创建时间：</td>
		   			<td><input type="text" readonly="true" id="createTime" name="createTime"/>&nbsp;<font color="red">*</font></td>
		   		</tr>
		   		<tr>
		   			<td>指派给：</td>
		   			<td><input class="easyui-combobox" id="assignMan" name="assignMan" data-options="panelHeight:'auto',editable:false,valueField:'trueName',textField:'trueName',url:'${ctx}/user/getCustomerManagerList.action'"/></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>指派时间：</td>
		   			<td><input type="text" id="assignTime" name="assignTime" readonly="readonly"/></td>
		   		</tr>
		   	</table>
		</form>
	</div>
	<!-- 添加和修改的dialog 结束 -->
		 
</body>
</html>