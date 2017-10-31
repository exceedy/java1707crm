<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<%@include file="../common/head.jsp" %>
		<script type="text/javascript">
			function openTab(titleText,url,icon){
				//如果这个tab已经存在，切换到这个tab
				//exists which 表明指定的面板是否存在，'which'参数可以是选项卡面板的标题或索引。 
				if ($("#tabsId").tabs("exists",titleText)) {
					//select which 选择一个选项卡面板，'which'参数可以是选项卡面板的标题或者索引。 
					$("#tabsId").tabs("select",titleText);
				} else {
					//如果这个tab不存在，创建这个tab
					var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='"+url+"'></iframe>";
					$("#tabsId").tabs("add",{
						title:titleText,
						iconCls:icon,
						closable:true,
						content:content
					});
				}
				
			}
		</script>
	</head>
	<body class="easyui-layout" >
		<!--北边-->
	    <div data-options="region:'north',split:false" style="height:80px;">
		    <table style="padding: 5px" width="100%">
				<tr>
					<td width="50%"><img alt="logo"
						src="${pageContext.request.contextPath}/images/bglogo.png"></td>
					<td valign="bottom" align="right" width="50%"><font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${currentUser.userName }</font>【${currentUser.trueName }】【${currentUser.roleName }】
					</td>
				</tr>
			</table>
	    </div>   
	    <!--西-->
	    <div data-options="region:'west',title:'导航菜单',split:false" style="width:200px;">
	    	<!--手风琴-->
	    	<div class="easyui-accordion" data-options="fit:true,border:false">   
	    		<div title="营销管理" data-options="selected:true,iconCls:'icon-yxgl'"
				style="padding: 10px">
				<a
					href="javascript:openTab('营销机会管理','${ctx}/saleChance/index.action','icon-yxjhgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-yxjhgl'"
					style="width: 150px">营销机会管理</a> 
			<a
					href="javascript:openTab('客户开发计划','cusdevplanManage.jsp','icon-khkfjh')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-khkfjh'"
					style="width: 150px">客户开发计划</a>
			</div>
			   <div title="客户管理"  data-options="iconCls:'icon-khgl'" style="padding:10px;">
					<a href="javascript:openTab('客户信息管理','customerManage.jsp','icon-khxxgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khxxgl'" style="width: 150px;">客户信息管理</a>
					<a href="javascript:openTab('客户流失管理','customerLossManage.jsp','icon-khlsgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khlsgl'" style="width: 150px;">客户流失管理</a>
				</div>
				<div title="服务管理" data-options="iconCls:'icon-fwgl'" style="padding:10px">
					<a href="javascript:openTab('服务创建','customerServiceCreate.jsp','icon-fwcj')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwcj'" style="width: 150px;">服务创建</a>
					<a href="javascript:openTab('服务分配','customerServiceAssign.jsp','icon-fwfp')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwfp'" style="width: 150px;">服务分配</a>
					<a href="javascript:openTab('服务处理','customerServiceProce.jsp','icon-fwcl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwcl'" style="width: 150px;">服务处理</a>
					<a href="javascript:openTab('服务反馈','customerServiceFeedback.jsp','icon-fwfk')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwfk'" style="width: 150px;">服务反馈</a>
					<a href="javascript:openTab('服务归档','customerServiceFile.jsp','icon-fwgd')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwgd'" style="width: 150px;">服务归档</a>
				</div>
				<div title="统计报表"  data-options="iconCls:'icon-tjbb'" style="padding:10px">
					<a href="javascript:openTab('客户贡献分析','khgxfx.jsp','icon-khgxfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khgxfx'" style="width: 150px;">客户贡献分析</a>
					<a href="javascript:openTab('客户构成分析','khgcfx.jsp','icon-khgcfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khgcfx'" style="width: 150px;">客户构成分析</a>
					<a href="javascript:openTab('客户服务分析','khfwfx.jsp','icon-khfwfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khfwfx'" style="width: 150px;">客户服务分析</a>
					<a href="javascript:openTab('客户流失分析','khlsfx.jsp','icon-khlsfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khlsfx'" style="width: 150px;">客户流失分析</a>
				</div>
				<div title="基础数据管理"  data-options="iconCls:'icon-jcsjgl'" style="padding:10px">
					<a href="javascript:openTab('数据字典管理','${ctx}/dataDic/index.action','icon-sjzdgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 150px;">数据字典管理</a>
					<a href="javascript:openTab('产品信息查询','${ctx}/product/index.action','icon-cpxxgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cpxxgl'" style="width: 150px;">产品信息查询</a>
					<a href="javascript:openTab('用户信息管理','${ctx}/user/index.action','icon-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user'" style="width: 150px;">用户信息管理</a>
				</div>
				<div title="系统管理"  data-options="iconCls:'icon-item'" style="padding:10px">
					<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
					<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
				</div>
			</div>  
	    </div>   
	    <!--中间-->
    	<div data-options="region:'center'" style="padding:5px;background:#eee;">
    		<div id="tabsId" class="easyui-tabs" data-options="fit:true">   
			    <div title="首页" data-optio="iconCls:icon-home">   
			        	<div align="center" style="padding-top: 100px">
					<font color="red" size="10">欢迎使用</font>
				</div> 
			    </div>   
			</div>
    	</div>   
    	<!--南边-->
    	<div data-options="region:'south',split:false" style="height:25px;" align="center">
    		版权所有 Java1707
    	</div>   
	</body>
</html>
