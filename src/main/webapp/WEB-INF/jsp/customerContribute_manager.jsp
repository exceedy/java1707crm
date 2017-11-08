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
 			url:'${ctx}/customer/findCustomerContribute.action',
			rownumbers:true,
			fitColumns:true,
			pagination:true,
			checkOnSelect:true,
			fit:true,
			singleSelect:false,
			method:'get',
			toolbar:'#toolbar',
			columns:[[
			        	{field:'name',align:'center',width:100,title:'客户名称'},
			        	{field:'total',align:'center',width:100,title:'订单总金额'},
			        	]]
 		})
 	})
 
	 function  doSearch() {
			$("#datagrid").datagrid("load",{
				"name":$("#name").val(),
			});
		}
		 
</script> 
<body>
	<!-- 数据表格 -->
		<table id="datagrid">
		</table>
		<!-- 表格按钮 -->
		<div id="toolbar">
		客户名称：<input type="text" id="name" style="width:100px"/>
		<a href="javascript:doSearch()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		</div>
</body>
</html>