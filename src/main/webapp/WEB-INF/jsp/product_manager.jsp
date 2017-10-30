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
	function delete() {
		var ids = Util.getSelectionsIds("#datagrid");
		if (ids.length == 0) {
			$.messager.layer("系统提示","请选择要删除的信息");
			return;
		}
		
		$.messager.layer("系统提示","确定要删除吗",function (r) {
			if (r) {
				$.post(
					"${ctx}/product/delete.action",
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
</script>
<body>
		<table id="datagrid" calss="easyui-datagrid" data-options="
			resizeHandle:'both',
			fitColumns:true,
			method:'get',
			url:'${ctx}/product/pageList.action',
			fit:'true',
			toolbar:'#toolbar'
			pagination:'true'
		" >
			<thead>
				<th data-options="field:cb,checkbox:'true'" style="width:100px"></th>
				<th data-options="field:id,align:'center'" style="width:100px">编号</th>
				<th data-options="field:productName,align:'center'" style="width:100px">商品名称</th>
				<th data-options="field:model,align:'center'" style="width:100px"></th>
				<th data-options="field:unit,align:'center'" style="width:100px"></th>
				<th data-options="field:price,align:'center'" style="width:100px">商品价格</th>
				<th data-options="field:store,align:'center'" style="width:100px"></th>
				<th data-options="field:remark,align:'center'" style="width:100px"></th>
			</thead>
		</table>
		
		<div id="toolbar">
			<a href="javascript:openAddDialog()" class="easyui-linkbutton" iconCls="icon-add" >添加</a>
			<a href="javascript:openUpdateDialog()" class="easyui-linkbutton" iconCls="icon-edit" >修改</a>
			<a href="javascript:delete()" class="easyui-linkbutton" iconCls="icon-remove" >删除</a>
			<input class="easyui-searchbox" data-options="prompt:'用户名',searcher:doSearch" style="width:300px"></input>
		</div>
</body>
</html>