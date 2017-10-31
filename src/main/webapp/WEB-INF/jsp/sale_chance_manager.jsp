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
 			        	{field:'linkMan',align:'center',width:100,titlr:'联系人'},
 			        	{field:'linkPhone  ',align:'center',width:100,title:'联系方式'},
 			        	{field:'createMan  ',align:'center',width:100,title:'创建人'},
 			        	{field:'createTime',align:'center',width:100,title:'创建时间'},
 			        	{field:'status',align:'center',width:100, title:'状态',
 			        		formatter: function(value,row,index){
 			   				if (value == 0){
 			   					return '未分配';
 			   				} else {
 			   					return '已分配';
 			   				}
 			   			}
 			        	}
 			        	
 			        	
 			     ]]
 		})
 		
 	})
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
				"linkMan":$("#linkMan").val(),
				"overview":$("#overview").val(),
				"createMan":$("#createMan").val(),
				"status":$("#status").val(),
				'startTime':$('#startTime').val(),
				"endTime":$('#endTime').val()
			})
		}
	 var url;
	 function openAddDialog() {
		 $("#dialog").dialog("open").dialog("setTitle","添加");
		 $("#form").form("clear");
		 url="$(ctx)/saleChance/add.action"
	 }
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
				客户名称：<input type="text" id="linkMan" style="width:100px"/>
				摘要：<input type="text" id="overview" style="width:100px"/>
				创建人：<input type="text" id="createMan" style="width:100px"/>
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
		 
		 <!-- 对话窗口 -->
		 <div class="easyui-dialog" id="dialog"  style="width:600px">
		 	<form action="" id="form" method="post">
		 		<table>
		 			<tr>
					<td>
		      			  客户名称: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <input class="easyui-validatebox" type="text" name="customerName" data-options="required:true" /><font color="red">*</font>   
					</td>
					 <td>机会来源:</td> 
					 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>  
		        	<td><input class="easyui-validatebox" type="text" name="chanceSource"  /></td>   
				</tr>
		 			<tr>
					<td>
		      			  联系人: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <input class="easyui-validatebox" type="text" name="linkMan" data-options="required:true" /><font color="red">*</font>   
					</td>
					 <td>联系方式:</td> 
					 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>  
		        	<td><input class="easyui-validatebox" type="text" name="linkPhone" data-options="required:true" /><font color="red">*</font></td>   
				</tr>
		 			<tr>
					<td>
		      			  成功几率: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <input class="easyui-validatebox" type="text" name="successRate" data-options="required:true" /><font color="red">*</font>   
					</td>
				</tr>
		 			<tr>
					<td>
		      			  摘要: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <input class="easyui-validatebox" type="text" name="overview" style="width:300px"  />   
					</td>
				</tr>
		 			<tr>
					<td>
		      			  机会描述: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <textarea class="easyui-validatebox"  name="description" style="width:300px"  />  
					</td>
				</tr>
				<tr>
					<td>
		      			  创建人: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <input class="easyui-validatebox" type="text" name="createMan" data-options="required:true" /><font color="red">*</font>   
					</td>
					 <td>创建时间:</td> 
					 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>  
		        	<td><input class="easyui-validatebox" type="text" name="createTime" data-options="required:true" /><font color="red">*</font>   </td>   
				</tr>
				<tr>
					<td>
		      			  指派给: 
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
					        <input class="easyui-combobox"  data-options="
					        	url:'${ctx}/saleChance/findSaleChanceAssignMan.action',
					        	valueField:'assignMan',
					        	textField:'assignMan',
					        	panelHeight:'auto',
					 		editable:false 
					        " /><font color="red">*</font>   
					</td>
					 <td>指派时间:</td> 
					 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>  
		        	<td><input class="easyui-validatebox" type="text" name="assigeTime" data-options="required:true" /><font color="red">*</font>   </td>   
				</tr>
				
		 		 </table>
		 	</form>
		 </div>
		 
</body>
</html>