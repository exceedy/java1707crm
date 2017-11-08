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
 
 	
 	//对话框
 	$(function () {
 		$("#createPeople").val("${currentUser.name}");
		 $("#createTime").val(Util.getCurrentDateTime());
 	})
		
	 //修改和添加的提交
	 function doSave() {
		 $("#form").form("submit",{
			 url: "${ctx}/customerService/add.action",
			 onSubmit: function () {
				 return $(this).form("validate");                                                                                                                                                                                                                                                                                                           
			 },
			   
			 success:function (result) {
				 var result = eval('('+ result +')');
				 if (result.status == Util.SUCCESS) {
					 $.messager.alert(result.msg);
				 } else {
					 $.messager.alert(result.msg);
				 }
			 }
		 })
	 }
 	
 	function doClear () {
 		$("#form").form("clear")
 	}
</script> 
<body>
		<!-- 添加dialog 开始 -->
	<div id="dialog" modal="true" class="easyui-panel" title="客户服务创建"  style="width:650;height:280,padding: 10px 20px">
		<form action="" id="form" method="post">
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
		   		<tr>
		   			<td>服务类型：</td>
		   			<td><input type="text" id="serviceType" name="serviceType" class="easyui-combobox" data-options="panelHeight:'auto',editable:false,valueField:'dataDicValue',textField:'dataDicValue',url:'${ctx}/dataDic/findByDataDicName.action?name=服务类型'" required="true"/>&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>客户：</td>
		   			<td><input type="text" id="customer" name="customer" /></td>
		   		</tr>
		   		<tr>
		   			<td>概要：</td>
		   			<td colspan="4"><input type="text" id="overview" name="overview" style="width: 420px"/></td>
		   		</tr>
		   		<tr>
		   			<td>服务请求：</td>
		   			<td colspan="4">
		   				<textarea rows="5" cols="50" id="serviceRequest" name="serviceRequest"></textarea>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>创建人：</td>
		   			<td><input type="text" readonly="true" id="createPeople" name="createPeople"  />&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>创建时间：</td>
		   			<td><input type="text" readonly="true" id="createTime" name="createTime"/>&nbsp;<font color="red">*</font></td>
		   		</tr>
		   	</table>
		</form>
	</div>
	<!-- 添加和修改的dialog 结束 -->
		 <div>
				 <a href="javascript:doSave()" class="easyui-linkbutton" iconCls="icon-add" >保存</a>
				<a href="javascript:doClear()" class="easyui-linkbutton" iconCls="icon-edit" >重置</a>
			</div>
</body>
</html>