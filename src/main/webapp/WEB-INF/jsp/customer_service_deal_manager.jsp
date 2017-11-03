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
			url:'${ctx}/customerService/pageList.action',
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
			        	{field:'customer',align:'center',width:100,title:'客户'},
			        	{field:'overview',align:'center',width:100,title:'概要'},
			        	{field:'serviceType',align:'center',width:100,title:'服务类型'},
			        	{field:'createPeople',align:'center',width:100,title:'创建人'},
			        	{field:'createTime',align:'center',width:100,title:'创建时间'},
			        	{field:'assigner',align:'center',width:100,title:'分配人'},
			        	{field:'assignTime',align:'center',width:100,title:'分配时间'}
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
 		$("#createPeople").val("${currentUser.name}");
		 $("#createTime").val(Util.getCurrentDateTime());
 	});
 	var url;
	//分配的弹出框
 	 function openUpdateDialog() {
		 var selected = $("#datagrid").datagrid("getSelections");
		 if (selected.length == 0) {
			 $.messager.alert("系统提示","请选择要处理的服务");
			 return;
		 }
		 $("#dialog").dialog("open").dialog("setTitle","处理客服服务");
			 
		 $("#form").form("load",selected[0]);
		 if (selected[0].serviceDealPeople == null) {
	 		$("#serviceDealPeople").val("${currentUser.name}");
			 $("#serviceDealTime").val(Util.getCurrentDateTime());
		 }
		 url = '${ctx}/customerService/update.action';
	 }
 	
	 //修改和添加的提交
	 function doSave() {
		 $("#form").form("submit",{
			 url: url,
			 onSubmit: function () {
				 return $(this).form("validate");                                                                                                                                                                                                                                                                                                           
			 },
			   
			 success:function (result) {
				 var result = eval('('+ result +')');
				 if (result.status == Util.SUCCESS) {
					 $.messager.alert('系统提示',result.msg);
					 $("#dialog").dialog("close");
					 $("#datagrid").datagrid("reload");
				 } else {
					 $.messager.alert('系统提示',result.msg);
				 }
			 }
		 })
	 };
	 $(function () {
		 $("#assigner").combobox({
			 onClick:function () {
				 $("#assignTime").val(Util.getCurrentDateTime());
			 }
		 })
	 }
	 )
</script> 
<body>
	<table id="datagrid"></table>
		<!-- 添加dialog 开始 -->
	<div id="dialog" modal="true" style="width:650;height:280,padding: 10px 20px">
		<form action="" id="form" method="post">
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
		   		<tr>
		   			<td>服务类型：</td>
		   			<td><input readonly="readonly" type="text" id="serviceType" name="serviceType" class="easyui-combobox" data-options="panelHeight:'auto',editable:false,valueField:'dataDicValue',textField:'dataDicValue',url:'${ctx}/dataDic/findByDataDicName.action?name=服务类型'" required="true"/>&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>客户：</td>
		   			<td><input readonly="readonly" type="text" id="customer" name="customer" /></td>
		   		</tr>
		   		<tr>
		   			<td>概要：</td>
		   			<td colspan="4"><input readonly="readonly" type="text" id="overview" name="overview" style="width: 420px"/></td>
		   		</tr>
		   		<tr>
		   			<td>服务请求：</td>
		   			<td colspan="4">
		   				<textarea readonly="readonly" rows="5" cols="50" id="serviceRequest" name="serviceRequest"></textarea>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>创建人：</td>
		   			<td><input type="text" readonly="true" id="createPeople" name="createPeople"  />&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>创建时间：</td>
		   			<td><input type="text" readonly="true" id="createTime" name="createTime"/>&nbsp;<font color="red">*</font></td>
		   		</tr>
		   		<tr>
		   			<td>分配给：</td>
		   			<td><input readonly="readonly" class="easyui-combobox" id="assigner" name="assigner" data-options="panelHeight:'auto',editable:false,valueField:'trueName',textField:'trueName',url:'${ctx}/user/getCustomerManagerList.action'"/></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>分配时间：</td>
		   			<td><input readonly="readonly" type="text" id="assignTime" name="assignTime" readonly="readonly"/></td>
		   		</tr>
		   		<tr>
		   			<td>服务处理：</td>
		   			<td colspan="4">
		   				<textarea rows="5" cols="50" id="serviceDeal" name="serviceDeal"></textarea>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>处理人：</td>
		   			<td><input type="text" readonly="true" id="serviceDealPeople" name="serviceDealPeople"  />&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>处理时间：</td>
		   			<td><input type="text" readonly="true" id="serviceDealTime" name="serviceDealTime"/>&nbsp;<font color="red">*</font></td>
		   		</tr>
		   	</table>
		</form>
	</div>
	<!-- 添加和修改的dialog 结束 -->
		 <div id="toolbar">
		 	<div>
				 <a href="javascript:openUpdateDialog()" class="easyui-linkbutton" iconCls="icon-fwcl" >处理</a>
			</div>
		 </div>
</body>
</html>