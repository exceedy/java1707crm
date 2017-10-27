<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<%@include file="../common/head.jsp" %>
<script type="text/javascript">
		function doSearch (value) {
			$("#datagrid").datagrid("load",{
				"userName":value
			})
		}
		function deleteUser() {
			var ids = Util.getSelectionsIds("#datagrid");
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
							if (result.status == Util.SUCCESS) {
								$.messager.alert("系统提示",result.msg);
								$("#dialog").datagrid("")
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
		var url;
		function openAddDialog() {
			$("#dlg").dialog("open").dialog("setTitle",'添加');
			$("#fm").form('clear');
			url="${ctx}/user/add.action"
		}
		
		function openUpdateDialog () {
			var selected = $("#datagrid").datagrid("getSelections");
			if (selected.length == 0) {
				$.messager.alert("系统提示","请选择要修改的信息");
				return;
			}
			$("#dlg").dialog("open").dialog("setTitle","修改");
			var row = selected[0];
			$("#fm").form("load",row);
			url="${ctx}/user/update.action";
		}
		
		function doSave() {
			$('#fm').form("submit",{
				url:url,
				 onSubmit: function(){    
				        // do some check    
				        if ($("#roleName").combobox("getValue") == "") {
				        	$.messager.alert("系统提示","请选择角色名")
				        	return false;
				        }
				        return $(this).form("validate");
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
<body>
	<!-- datagrid开始-->
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
	<!-- datagrid结束-->
	<!-- toolbar开始-->
	<div id="toolbar">
		<a href="javascript:openAddDialog()" class="easyui-linkbutton" iconCls="icon-add" >添加</a>
		<a href="javascript:openUpdateDialog()" class="easyui-linkbutton" iconCls="icon-edit" >修改</a>
		<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" >删除</a>
		<input class="easyui-searchbox" data-options="prompt:'用户名',searcher:doSearch" style="width:300px"></input>
	</div>
	<!-- toolbar结束-->
	<!-- dialog开始-->
	<div class="easyui-dialog" id="dlg" data-options="closable:true,closed:true,buttons:'#dlg-button'" style="whidth:400px">
		<form id="fm" method="post">
			<input type="hidden" id="id" name="id"/>
			<table> 
				<tr>
					<td>
		      			  用户名: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <input class="easyui-validatebox" type="text" name="userName" data-options="required:true" /><font color="red">*</font>   
					</td>
					 <td>密码:</td> 
					 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>  
		        	<td><input class="easyui-validatebox" type="text" name="password" data-options="required:true" /><font color="red">*</font></td>   
				</tr>
			<tr>   
		        <td >真实姓名:</td>   
		        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		        <td><input class="easyui-validatebox" type="text" name="trueName" data-options="required:true" />  <font color="red">*</font></td> 
		        <td >邮箱:</td>  
		        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td> 
		        <td><input class="easyui-validatebox" type="text" name="email" data-options="required:true,validType:'email'" /><font color="red">*</font></td>   
		    </tr>  
			<tr>   
		        <td >手机号:</td>  
		        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td> 
		       <td> <input class="easyui-validatebox" type="text" name="phone" data-options="required:true" />  <font color="red">*</font></td> 
		        <td for="roleName">角色:</td>   
		        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		        <td>
		        	<select id="roleName" name="roleName" class="easyui-combobox">
		        		<option value=""></option>   
					    <option value="高管">高管</option>   
					    <option value="销售主管">销售主管</option>   
					    <option value="客户经理" >客户经理</option>   
		       		</select>
		        	<font color="red">*</font>
		        </td>  
		    </tr> 
		    </table> 
		</form>
	</div>
	<!-- dialog结束-->
	<!-- dlg-button开始-->
	<div id = "dlg-button">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-ok',text:'提交'" href="javascript:doSave()"></a>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',text:'清空'" href="javascript:clear()"></a>
		<a></a>
	</div>
	<!-- dlg-button结束-->
	
</body>
</html>