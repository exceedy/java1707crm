<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<%@include file="../common/head.jsp" %>
		<script type="text/javascript">
			function doSave() {
				$("#form").form("submit",{
					url:'${ctx}/login/login.action',
					success:function (data) {
						var data = eval('('+ data +')');
						if (data.status == Util.SUCCESS) {
							$.messager.confirm('前往主页',data.msg,function (r) {
								if (r) {
									location.href="${ctx}/login/index.action";
								}				
							})
						} else {
							$.messager.alert('系统提示',data.msg);
						}
					}
				}) 
			}
		</script>
	</head>
	<body class="easyui-layout" >
		<p>登录</p>
	<div style="margin:20px 0;"></div>
	<div class="easyui-panel" title="Login to system" style="width:400px;padding:30px 70px 20px 70px">
		<form action="" id = "form">
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" name="name" style="width:100%;height:40px;padding:12px" data-options="prompt:'Username',iconCls:'icon-man',iconWidth:38">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="password" type="password" style="width:100%;height:40px;padding:12px" data-options="prompt:'Password',iconCls:'icon-lock',iconWidth:38">
			</div>
			<!-- <div style="margin-bottom:20px">
				<input type="checkbox" checked="checked">
				<span>Remember me</span>
			</div> -->
		</form>
		<div>
			<a href="javascript:doSave()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding:5px 0px;width:100%;">
				<span style="font-size:14px;">登录</span>
			</a>
		</div>
	</div>
	</body>
</html>
