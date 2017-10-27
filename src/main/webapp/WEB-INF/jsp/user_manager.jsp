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
	<table id="datagrid" class="easyui-datagrid" rownumbers="true" fitColumns="true"
		pagination="true"
		checkOnSelect="true"
		data-options="fit:true,singleSelect:false,url:'${ctx}/user/pageList.action',method:'get',toolbar:'#toolbar'">
		<thead>
			<tr>
				<th data-options="field:'cb',align:'center',checkbox:true" ></th>
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
		<a href="javascript:addUser()" class="easyui-linkbutton" iconCls="icon-add" >添加</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" >修改</a>
		<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" >删除</a>
		<input class="easyui-searchbox" data-options="prompt:'用户名',searcher:doSearch" style="width:300px"></input>
	</div>
	<div class="easyui-dialog" id="dlg" data-options="closable:true,closed:true,buttons:'#dlg-button'" style="whidth:400px">
		<form id="fm" method="post">
			<div class="">   
		        <label for="userName">用户名:</label>   
		        <input class="easyui-validatebox" type="text" name="userName" data-options="required:true" />   
		    </div>  
			<div>   
		        <label for="password">密码:</label>   
		        <input class="easyui-validatebox" type="text" name="password" data-options="required:true" />   
		    </div>  
			<div>   
		        <label for="trueName">真实姓名:</label>   
		        <input class="easyui-validatebox" type="text" name="trueName" data-options="required:true" />   
		    </div>  
			<div>   
		        <label for="email">邮箱:</label>   
		        <input class="easyui-validatebox" type="text" name="email" data-options="required:true" />   
		    </div>  
			<div>   
		        <label for="phone">手机号:</label>   
		        <input class="easyui-validatebox" type="text" name="phone" data-options="required:true" />   
		    </div>  
			<div class="fitem">   
		        <label for="roleName">角色:</label>   
		        <input class="easyui-validatebox" type="text" name="roleName" data-options="required:true" />   
		    </div>  
		</form>
	</div>
	<div id = "dlg-button">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-ok',text:'提交'" href="javascript:submit()"></a>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',text:'取消'" href="javascript:clear()"></a>
		<a></a>
	</div>
	<script type="text/javascript">
		function doSearch (value) {
			$("#datagrid").datagrid("load",{
				"userName":value
			})
		}
		function deleteUser() {
			var selectIds = $("#datagrid").datagrid('getSelections');
			var ids = [];
			
			for (var i in selectIds) {
				ids.push(selectIds[i].id);
			}
			ids = ids.join(",");
			if (ids.length == 0) {
				$.messager.alert("系统提示","请选择要删除的信息");
				return;
			}
			
			$.messager.confirm("系统提示","确定要删除吗",function(r) {
				if (r) {
					$.post(
						"${ctx}/user/delete.action",
						{ids:ids},
						function (result) {
							if (result.status == 0) {
								$.messager.alert("系统提示",result.msg);
								$("#datagrid").datagrid("reload")
							} else {
								$.messager.alert("系统提示",result.msg);
							}
						},
						"json"
					);
				}
			})
		}
		function addUser() {
			$("#dlg").dialog("open").dialog("setTitle",'添加');
			$("#fm").form('clear');
			url="${ctx}/user/addUser.action"
		}
		function submit() {
			$('#fm').form("submit",{
				url:url,
				 onSubmit: function(){    
				        // do some check    
				        // return false to prevent submit;    
				    },
				success:function (data) {
					var data = eval('(' + data + ')');  
					if (data.status == 0) {
						$.messager.alert("系统提示",data.msg);
						$("#datagrid").datagrid("reload");
					} else {
						$.messager.alert("系统提示",data.msg);
					} 
				}
			})
		}
		function clear() {
			$('#fm').form('clear');
		}
	</script>
</body>
</html>