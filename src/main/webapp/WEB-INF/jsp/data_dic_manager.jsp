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
	 function remove() {
		var ids = Util.getSelectionsIds("#datagrid");
		if (ids.length == 0) {
			$.messager.layer("系统提示","请选择要删除的信息");
			return;
		}
		
		$.messager.layer("系统提示","确定要删除吗",function (r) {
			if (r) {
				$.post(
					"${ctx}/dataDic/delete.action",
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
	 function  doSearch() {
			$("#datagrid").datagrid("load",{
				"dataDicName":$("#dataDicName").val(),
				"dataDicValue":$("#dataDicValue").val()
			});
		}
	 var url;
	 function openAddDialog() {
		 $("#dialog").dialog("open").dialog("setTitle","添加");
		 $("#form").form("clear");
		 url="$(ctx)/dataDic/add.action"
	 }
	 function openUpdateDialog() {
		 var selected = $("#datagrid").datagrid("getSelections");
		 if (selected.length == 0) {
			 $.messager.layer("系统提示","请选择要修改的信息");
			 return;
		 }
		 $("#dialog").dialog("open").dialog("setTitle","修改");
		 $("#form").form("load",selected[0]);
		 url = '${ctx}/dataDic/update.action';
	 }
	 
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
		 function clear() {
			 $("#form").form("clear");
		 }
</script> 
<body>
	<!-- 数据表格 -->
		<table id="datagrid" class="easyui-datagrid" rownumbers="true" fitColumns="true"
		pagination="true"
		checkOnSelect="true"
		data-options="fit:true,singleSelect:false,url:'${ctx}/dataDic/pageList.action',method:'get',toolbar:'#toolbar'">
		<thead>
			<thead>
				<tr>
					<th data-options="field:'cb',align:'center',checkbox:true" ></th>
					<th data-options="field:'id',align:'center',width:100" >编号</th>
					<th data-options="field:'dataDicName',align:'center',width:100" >数据字典名</th>
					<th data-options="field:'dataDicValue',align:'center',width:100" >数据字典值</th>
				</tr>
			</thead>
		</table>
		<!-- 表格按钮 -->
		<div id="toolbar">
		<div>
			 <a href="javascript:openAddDialog()" class="easyui-linkbutton" iconCls="icon-add" >添加</a>
			<a href="javascript:openUpdateDialog()" class="easyui-linkbutton" iconCls="icon-edit" >修改</a>
			<a href="javascript:remove()" class="easyui-linkbutton" iconCls="icon-remove" >删除</a>
		</div>
		<div>
			<div>
			数据字典名：<input type="text" id="dataDicName" class="easyui-combobox"
					 data-options="
					 	url:'${ctx}/dataDic/findDataDicName.action',
					 	valueField: 'dataDicName',
					 	textField: 'dataDicName',
					 	panelHeight:'auto',
					 	editable:false  "/>
		       数据字典值：<input type="text" id="dataDicValue"></input>
		  <a href="javascript:doSearch()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		</div>
		</div>
		 </div>
		 
		 <!-- 对话窗口 -->
		 <div class="easyui-dialog" buttons="#dialog-button" closed="true" closable="true" style="width:400px">
		 	<form action="" id="form" method="post">
		 		<table>
		 			<tr>
					<td>
		      			  数据字典名称: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <input class="easyui-validatebox" type="text" name="dataDicName" data-options="required:true" /><font color="red">*</font>   
					</td>
					 <td>数据字典值:</td> 
					 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>  
		        	<td><input class="easyui-validatebox" type="text" name="dataDicValue" data-options="required:true" /><font color="red">*</font></td>   
				</tr>
		 		</table>
		 	</form>
		 </div>
		 
		 <div id="dialog-button">
		 	<a class="easyui-linkbutton" data-options="iconCls:'icon-ok',text:'提交'" href="javascript:doSave()"></a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',text:'清空'" href="javascript:clear()"></a>
		 </div>
</body>
</html>