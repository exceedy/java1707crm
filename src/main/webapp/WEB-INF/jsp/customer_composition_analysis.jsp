<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<%@include file="../common/head.jsp" %>
		<script type="text/javascript">
		$(function() {
			 // 基于准备好的dom，初始化echarts实例
		   var myChart = echarts.init(document.getElementById('main'));

		   // 异步加载数据
		   $.post('${ctx}/customer/composition.action',
		   		function(result){
		   			if(result.status == Util.SUCCESS) {
		   				var xAxisData=new Array();
							var seriesData=new Array();
							var data = result.data;
							for(var i=0;i<data.length;i++){
								xAxisData.push(data[i].name);
								console.log(data[i].name);
								seriesData.push(data[i].total);
								console.log(data[i].total);
							}
							console.log(xAxisData);
				        	// 填入数据
				            myChart.setOption({
				                title: {
				                    text: '客户构成分析'
				                },
				                tooltip: {},
				                legend: {
				                    data:['数量']
				                },
				                xAxis: {
				                    data: xAxisData
				                },
				                yAxis: {},
				                series: [{
				                    // 根据名字对应到相应的系列
				                    name: '数量',
				                    type: 'bar',
				                    data: seriesData
				                }]
				            });
		   			} else {
		   				alert("查询失败");
		   			}
			        	
		   		},
		   		'json'
		   	);
		   
		});

		</script>
	</head>
	<body  >
		 <div id="main" style="width: 600px;height:400px;"></div>
	</body>
</html>
