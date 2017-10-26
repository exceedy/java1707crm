<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<%@include file="../common/head.jsp" %>
<body>
	<table class="easyui-datagrid" rownumbers="true" fitColumns="true"
		pagination="true"
		data-options="fit:true,singleSelect:true,url:'${ctx}/user/pageList.action',method:'get',toolbar:'#toolbar'">
		<thead>
			<tr>
				<th data-options="field:'id',align:'center',width:80" >编号</th>
				<th data-options="field:'userName',align:'center',width:80">用户名</th>
				<th data-options="field:'password',align:'center',width:80">密码</th>
				<th data-options="field:'trueName',align:'center',width:80">真实姓名</th>
				<th data-options="field:'email',align:'center',width:80">邮箱</th>
				<th data-options="field:'phone',align:'center',width:80">手机号</th>
				<th data-options="field:'roleName',align:'center',width:80">角色</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" >添加</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" >修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" >删除</a>
	</div>
</body>
</html>