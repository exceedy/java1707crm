var Util = {
	//回调执行成功时返回代表代码执行成功的状态
	SUCCESS:0,
	//回调执行成功时返回代表代码执行失败的状态
	ERROR:1,
	getSelectionsIds:function (datagridId) {
									var selectIds = $(datagridId).datagrid("getSelections");
									var ids = [];
									for (var i in selectIds) {
										ids.push(selectIds[i].id);
											}
									ids = ids.join(",");
									return ids;
								}
}