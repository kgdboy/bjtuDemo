<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Title</title>
</head>
<style>
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code,
	form, fieldset, legend, input, button, textarea, p, blockquote, th {
	margin: 0;
	padding: 0;
}

;
.clearfix:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
	visibility: hidden;
}

.clearfix {
	*zoom: 1;
}

body {
	background: url("./img/bgblue.jpg") repeat 0;
}

#wrap {
	width: 900px;
	margin: 10px auto;
	margin-bottom: 0;
}

#wrap #content {
	margin: 30px 0;
}

table {
	font-size: 20px;
	font-family: "微软雅黑", Verdana;
	color: #fff9ec;
}

tr th, td {
	text-align: center;
}
</style>
<script src="./js/jquery-1.10.2.min.js"></script>
<script src="./js/layer.js"></script>
<script src="./bs3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./bs3/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/layer.css">
<script>
	$(function() {
		//发送ajax请求,发送请求参数是单位名称，返回该单位所有人员虚拟帐户金额小于0的信息，包括：部门、姓名、工资号、金额
		// SELECT Bm,Name,vmoney,gz_number from user where vmoney<0 ORDER BY Bm";
		$.post("${pageContext.request.contextPath}/TestServlet", {
			"orga_id" : '${sessionScope.UserBean.orga_id}'
		}, function(result) {
			var code = JSON.parse(result);
			var tablehtml = "<tr><th>序号</th><th>部门</th><th>姓名</th><th>工资号</th><th>金额(元)</th></tr>";
			for (var i = 0,j=0; i < code.data.length; i++) {
				tablehtml += "<tr style='text-align: center'><td>" + (++j) + "</td>" +
					"<td>" + code.data[i].depart_name + "</td>" +
					"<td>" + code.data[i].name + "</td>" +
					"<td>" + code.data[i].salary_number + "</td>"+
					"<td>" + code.data[i].virtual_account + "</td></tr>";
			}
		
			$("#table1").html(tablehtml);
		})
		//当点击刷新人员时
		$("#flush").click(function() {
			window.location.reload();
		})
		//当点击导出按钮时
		$("#dc").click(function() {
			var day = $("#day").val();
			if (day >= 15 && day <= 18) {
				$("#clear").removeAttr('disabled');
				window.location.href = "jsdc_excel.php";
			} else {
				layer.alert('只能在每月15-18日之间导出数据');
				return false;
			}
		})
		//当点击帐户余额清零按钮时
		$("#clear").click(function() {
			layer.confirm('您的操作会将以下名单的帐户清零,是否继续', {
				btn : [ '我确认', '官人不要' ] //按钮
			}, function() {
				var day = $("#day").val();
				if (day >= 15 && day <= 18) {
					//发送ajax请求
					$.post("clear_money_ajax.php", {
						day : day
					}, function(data) {
						if (data == 1) {
							layer.alert('帐户余额清零成功,3秒后自动刷新！');
							$("#clear").attr('disabled', 'disabled');
							setTimeout(function() {
								window.location.reload();
							}, 3000);
						}
					})
				} else {
					layer.alert('只能在每月15-18日之间导出数据');
					return false;
				}
			})
		})

		//各按钮的提示功能
		$("#flush").mouseover(function() {
			layer.tips('可获取最新人员余额情况', $("#flush"), {
				tips : [ 1, "#38a38a" ],
				time : 4000
			});
		})
		$("#dc").mouseover(function() {
			layer.tips('每月15日-18日可导出欠费人员名单', $("#dc"), {
				tips : [ 1 ],
				time : 4000
			});
		})
		$("#clear").mouseover(function() {
			layer.tips('危险操作：请确认已将人员名单导出。', $("#clear"), {
				tips : [ 1, 'red' ],
				time : 4000
			});
		})

	})
</script>
<body>
	<div id="wrap" class="clearfix">
		<div id="title_gif">
			<img src="./img/js.png" alt="" />
		</div>


		<div id="content">
			<div id="btn-group" style="text-align: center">
				<input type="button" style="width: 220px;margin-right: 50px"
					class="btn btn-lg btn-info" value="刷新人员数据" id="flush"> <input
					type="button" style="width: 220px;margin-right: 50px"
					class="btn btn-lg btn-success" value="导出名单到Excel" id="dc">
				<input type="button" style="width: 220px;margin-right: 50px"
					class="btn btn-lg btn-danger" disabled value="帐户余额清零" id="clear">
			</div>

			<hr>
			<div class="">
				<table class="table table-bordered" id="table1">
				</table>
			</div>
		</div>
	</div>
	<input type="hidden" name="day" id="day" value="<?php echo $day;?>">
</body>
</html>
