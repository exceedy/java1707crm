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
		   $.post('${ctx}/customerService/service.action',
		   		function(result){
		   			if(result.status == Util.SUCCESS) {
		   				
		   				var xAxisData=new Array();
							var seriesData=new Array();
							var data = result.data;
							for(var i=0;i<data.length;i++){
								xAxisData.push(data[i].name);
							}
							option = {
								    tooltip: {
								        trigger: 'item',
								        formatter: "{a} <br/>{b}: {c} ({d}%)"
								    },
								    legend: {
								        orient: 'vertical',
								        x: 'left',
								        data:xAxisData
								    },
								    series: [
								        {
								            name:'访问来源',
								            type:'pie',
								            radius: ['50%', '70%'],
								            avoidLabelOverlap: false,
								            label: {
								                normal: {
								                    show: false,
								                    position: 'center'
								                },
								                emphasis: {
								                    show: true,
								                    textStyle: {
								                        fontSize: '30',
								                        fontWeight: 'bold'
								                    }
								                }
								            },
								            labelLine: {
								                normal: {
								                    show: false
								                }
								            },
								            data:data
								        }
								    ]
								};
							myChart.setOption(option);
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
