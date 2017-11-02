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
 			url:'${ctx}/customer/pageList.action',
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
 			        	{field:'num',align:'center',width:100,title:'客户编号'},
 			        	{field:'name',align:'center',width:100,title:'客户名称'},
 			        	{field:'managerName',align:'center',width:100,title:'客户经理'},
 			        	{field:'level  ',align:'center',width:100,title:'客户等级'},
 			        	{field:'phone  ',align:'center',width:100,title:'联系电话'},
 			        	{field:'region',align:'center',width:100,title:'客户地区'},
 			        	{field:'satisfy',align:'center',width:100,title:'客户满意度'},
 			        	{field:'credit',align:'center',width:100,title:'客户信任度'}
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
					"${ctx}/customer/delete.action",
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
				'num':$("#num").val(),
				'name':$("#name").val()
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
		 url="${ctx}/customer/add.action"
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
		 url = '${ctx}/customer/update.action';
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
				客户名称：<input type="text" id="name" style="width:100px"/>
				客户编号：<input type="text" id="num" style="width:100px"/>
			</div>
		 </div>
		 
		<!-- 添加和修改的dialog 开始 -->
	<div id="dialog" modal="true" style="width:650;height:280,padding: 10px 20px">
		<form action="" id="form" method="post">
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
		   		<tr>
		   			<td style="width:150px">客户名称：</td>
		   			<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td style="width:150px">地区：</td>
		   			<td>
		   				<select required="true" name="region" id="region" class="easyui-combobox">
		   					<option vlaue="">请选择地区</option>
		   					<option value="北京">北京</option>
		   					<option value="上海">上海</option>
		   					<option value="青岛">青岛</option>
		   				</select>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">客户经理：</td>
		   			<td><input required="true" class="easyui-combobox" id="managerName" name="managerName" data-options="panelHeight:'auto',editable:false,valueField:'trueName',textField:'trueName',url:'${ctx}/user/getCustomerManagerList.action'"/></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td style="width:150px">客户等级</td>
		   			<td>
		   				<input required="true" class="easyui-combobox" id="level" name="level" data-options="panelHeight:'auto',editable:false,valueField:'trueName',textField:'trueName',url:'${ctx}/dataDic/findByDataDicName.action'"/>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">客户满意度：</td>
		   			<td>
		   			<select required="true" name="satisfy" id="satisfy" class="easyui-combobox">
		   					<option vlaue="">--请选择--</option>
		   					<option value="☆☆☆☆☆">☆☆☆☆☆</option>
		   					<option value="☆☆☆">☆☆☆</option>
		   					<option value="☆">☆</option>
		   				</select>
		   				</td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			
		   			<td style="width:150px">客户信用度：</td>
		   			<td><select required="true" name="credit" id="credit" class="easyui-combobox">
		   					<option vlaue="">--请选择--</option>
		   					<option value="☆☆☆☆☆">☆☆☆☆☆</option>
		   					<option value="☆☆☆">☆☆☆</option>
		   					<option value="☆">☆</option>
		   				</select>
		   				</td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">邮政编码：</td>
		   			<td ><input required="true" type="text" id="postCode" name="postCode" /></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td style="width:150px">联系电话：</td>
		   			<td ><input type="text" id="phone" name="phone" /></td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">传真：</td>
		   			<td ><input required="true" type="text" id="fax" name="fax" /></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td style="width:150px">网址：</td>
		   			<td ><input required="true" type="text" id="webSite" name="webSite" /></td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">客户地址：</td>
		   			<td colspan="4">
		   				<textarea required="true" rows="5" cols="50" id="address" name="address"></textarea>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">营业执照注册号：</td>
		   			<td><input type="text"  id="licenceNo" name="licenceNo"  />&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td style="width:150px">法人：</td>
		   			<td><input required="true" type="text"  id="legalPeson" name="legalPeson"/>&nbsp;<font color="red">*</font></td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">注册资金（万元）：</td>
		   			<td><input  type="text"  id="bankroll" name="bankroll"  />&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td style="width:150px">年营业额（万元）：</td>
		   			<td><input required="true" type="text"  id="turnover" name="turnover"/>&nbsp;<font color="red">*</font></td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">开户银行：</td>
		   			<td><input required="true" type="text"  id="bankName" name="bankName"  />&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td style="width:150px">开户账号：</td>
		   			<td><input required="true" type="text"  id="bankAccount" name="bankAccount"/>&nbsp;<font color="red">*</font></td>
		   		</tr>
		   		<tr>
		   			<td style="width:150px">地税登记号：</td>
		   			<td><input type="text"  id="localTaxNo" name="localTaxNo"  />&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td style="width:150px">国税登记号：</td>
		   			<td><input type="text"  id="natiinalTaxNo" name="natiinalTaxNo"/>&nbsp;<font color="red">*</font></td>
		   		</tr>
		   	</table>
		</form>
	</div>
	<!-- 添加和修改的dialog 结束 -->
		 
</body>
</html>