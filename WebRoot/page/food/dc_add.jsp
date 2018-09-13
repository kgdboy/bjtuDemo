<%@ page language="java" import="java.util.*,bjtu.gruop7.bean.UserBean"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//判断session信息
	HttpSession sn = request.getSession();
	UserBean bean = (UserBean) sn.getAttribute("UserBean");
	String lev = bean.getLev();
	/* System.out.println(lev); */
	if (bean == null) {
		response.sendRedirect(request.getContextPath() + "/login.html");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>智慧生活 在线订餐</title>

</head>
<link rel="stylesheet" href="./css/dc_add.css">
<link rel="stylesheet" href="./bs3/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/skin/layer.css">
<link rel="stylesheet" href="../../frame/layui225/css/layui.css">
<script src="./js/jquery-1.10.2.min.js"></script>
<script src="./bs3/js/bootstrap.min.js"></script>
<script src="./layui/layui.js"></script>
<body>
	<div id="wrap" class="clearfix">
		<div id="title_gif">
			<img src="./img/foods.gif" alt="" />
		</div>
		<div id="content">
			<table class="" align="center" width="100%" cellspacing="0"
				cellpadding="8">
				<form action="" method="POST" name="form">
					<tr>
						<td width="25%">
							<div align="center">
								<img src="./img/morning.jpg.png" alt="" class="tu" id="morning" />
							</div>
						</td>
						<td width="25%">
							<div align="center">
								<img src="./img/afternoon.jpg.png" alt="" class="tu"
									id="afternoon">
							</div>
						</td>
						<td width="25%">
							<div align="center">
								<img src="./img/evening.jpg.png" alt="" class="tu" id="evening">
							</div>
						</td>
					</tr>
			</table>
			<div id="footer" class="btn-lg">
				<input type="button" class="btn  btn-success" value="一周食谱"
					id="view_cp"> <input type="button" class="btn  btn-info"
					value="意见建议" id="cppj"> <input type="button" id="wctd"
					name="ok" class="btn  btn-danger" value="午餐退订" />
			</div>
			</form>
			<div class="remark">
				<p class="title">订餐时间我们是这么规定的</p>
				<p class="p">早餐订餐时间为：12:00——18:00</p>
				<p class="p">午餐订餐时间为：12:00——09:00</p>
				<p class="p">晚餐订餐时间为：12:00——15:00</p>
			</div>
			<div class="remark">
				<p class="title">退餐我们要求是严格的</p>
				<p class="p" style="color:red;">不支持早餐的退订</p>
				<p class="p">午餐退订时间：09:00 之前</p>
				<p class="p" style="color:red;">不支持晚餐的退订</p>
			</div>
			<div class="remark">
				<p class="title">伙食费扣费说明</p>
				<p class="p">每月18日前由管理员进行费用结算</p>
				<p class="p">每月结算后欠费人员帐户余额归零</p>
				<p class="p">每月伙食费将在本月工资中扣除</p>
			</div>
		</div>
	</div>
	<div class="small_tips">
		<span class="s">小提示：网络订餐只适用于段机关科室人员，车间来段就餐人员需要到办公室购买饭票</span>
	</div>
	<hr>
	<div class="small_bq">
		<img src="./img/icon.png" alt=""> <span class="s"> <b>智慧生活</b><b>网络订餐</b><b>软件开发</b><b>
				© 信息技术提高班——第七组</b></span>
	</div>


<script>
	layui.use('layer', function() {
		var layer = layui.layer,
			$ = layui.$;
		$(function() {
//鼠标移动到图片旋转
			$("#content img").mouseover(function() {
				$(this).css('transform', 'rotate(5deg)');
			})
			$("#content img").mouseout(function() {
				$(this).css('transform', 'rotate(0deg)');
			})
//页面登陆后提示用户余额
/* 
	此处应发起ajax请求，发送一个工资号码，返回用户当前余额
 */
 			// 发起AJAX请求
		$.post("${pageContext.request.contextPath}/RequestMoneyServlet",{"salary_number":'${sessionScope.UserBean.salary_number}'},function(data){
	        // 判断第一个字符是否非法
			var firstCode = data.charCodeAt(0);
			if (firstCode < 0x20 || firstCode > 0x7f) {
				data = data.substring(1); // 去除第一个字符
			}
	            data = $.parseJSON(data);
	            console.log(data);
		    if (data.code==0){
			    	layer.alert("<span style='font-size: 22px;font-family: 微软雅黑;'>${ sessionScope.UserBean.depart_name}${ sessionScope.UserBean.name}您好, 您的帐户当前余额为："+data.virtual_account +"元</span>", {
					title : '余额提醒',
					time : 5000, //5秒后自动关闭
					area : [ '630px', '160px' ],
					skin : 'layui-layer-lan', //样式类名
					anim : 2
				})
		    }else{
		    	layer.alert("余额获取失败,"+data.message,{
		            icon:2,
		            shift:6,
		        })
		    }
		})
	
			//询问用户是否订早餐
			$("#morning").click(function() {
				layer.confirm('您确定要预定<span style="color:red;">明日</span>的早餐吗?（不可退餐）', {
					title : '预订早餐,我们将扣除您2元费用',
					icon : 3,
					skin : 'layui-layer-molv',
					btn : [ '是, 我非常确定', '不, 让我再想想' ] //按钮
				}, function() {
					//发送AJAX请求
					$.post("${pageContext.request.contextPath}/reservationMeal", {
						"reservationCategory" : "早餐",
						"salary_number":${sessionScope.UserBean.salary_number}
					}, function(result) {
						var code = JSON.parse(result);
						if (code[0] == 1) {
							layer.alert(code[1], {
								title : '很遗憾的提示您：',
								icon : 2,
								skin : 'layui-layer-molv'
							});
						} else if (code[0] == 0) {
							layer.alert('好的,预定成功啦,明天早上不见不散!', {
								title : '本次消费后,您的余额为：' + code[1] + '元',
								icon : 1,
								skin : 'layui-layer-molv'
							});
						}
					});

				}, function() {
					layer.alert('很遗憾,您取消了本次预订。', {
						title : '订餐失败',
						icon : 2,
						skin : 'layui-layer-molv'
					});
					return false;
				});

			})
			//订午餐
			$("#afternoon").click(function() {
				// 判断当前时间<9点为今日，大于12点为明日
				var sj = 666;
				if (sj < 9) {
					rq = '今日';
				} else {
					rq = '明日';
				}
				//询问用户是否订餐
				layer.confirm('您要预定' + rq + '的午餐吗?（09:00前可退餐）', {
					title : '预订午餐,我们将扣除您2元费用',
					icon : 3,
					skin : 'layui-layer-molv',
					btn : [ '是, 我非常确定', '不, 让我再想想' ] //按钮
				}, function() {
					//发送AJAX请求
					$.post("d5c_ajax.php", {
						lx : '午餐'
					}, function(result) {
						// console.log(result);return false;
						var code = JSON.parse(result);
						if (code[0] == 1) {
							layer.alert(code[1], {
								title : '很遗憾的提示您：',
								icon : 2,
								skin : 'layui-layer-molv'
							});
						} else if (code[0] == 0) {
							layer.alert('预定午餐成功 三菜一汤老地方等你', {
								title : '本次消费后,您的余额为：' + code[1] + '元',
								icon : 1,
								skin : 'layui-layer-molv'
							});
						}
					});
				}, function() {
					layer.alert('很遗憾,您取消了午餐的预订。', {
						title : '订餐失败',
						icon : 2,
						skin : 'layui-layer-molv'
					});
					return false;
				});

			})
			//订晚餐
			$("#evening").click(function() {
				//询问用户是否订餐
				layer.confirm('您确定要预定今日的晚餐吗?（不可退餐）', {
					title : '预订晚餐,我们将扣除您6元费用',
					icon : 3,
					skin : 'layui-layer-molv',
					btn : [ '是, 我非常确定', '不, 让我再想想' ] //按钮
				}, function() {
					//发送AJAX请求
					$.post("dwc_ajax.php", {
						lx : '晚餐'
					}, function(result) {
						var code = JSON.parse(result);
						if (code[0] == 1) {
							layer.alert(code[1], {
								title : '很遗憾的提示您：',
								icon : 2,
								skin : 'layui-layer-molv'
							});
						} else if (code[0] == 0) {
							layer.alert('好的,预定成功啦,您加班辛苦了!', {
								title : '本次消费后,您的余额为：' + code[1] + '元',
								icon : 1,
								skin : 'layui-layer-molv'
							});
						}
					});
				}, function() {
					layer.alert('很遗憾,您取消了本次预订。', {
						title : '订餐失败',
						icon : 2,
						skin : 'layui-layer-molv'
					});
					return false;
				});

			})
			//午餐退订
			$("#wctd").click(function() {
				//退午餐时间显示
				var sj = 666;
				if (sj < 9) {
					rq = '今日';
				} else {
					rq = '明日';
				}
				//用户退订午餐
				layer.confirm('您确定要退订' + rq + '的午餐吗?', {
					title : '退订成功后,我们将返还您2元费用',
					icon : 3,
					skin : 'layui-layer-molv',
					btn : [ '说啥也不吃了', '让我再想想吧' ] //按钮
				}, function() {
					//发送AJAX请求
					$.post("t5c_ajax.php", {
						lx : '午餐'
					}, function(result) {
						var code = JSON.parse(result);
						if (code[0] == 1) {
							layer.alert(code[1], {
								title : '很遗憾的提示您：',
								icon : 2,
								skin : 'layui-layer-molv'
							});
						} else if (code[0] == 0) {
							layer.alert('好的,午餐退订成功啦!', {
								title : '本次退订后,您的余额为：' + code[1] + '元',
								icon : 1,
								skin : 'layui-layer-molv'
							});
						}
					});
				});
			})
			//一周食谱公示
			$("#view_cp").click(function() {
				layer.open({
					type : 2,
					title : '锦州供电段 智慧生活 网络订餐 ———— 一周食谱由办公室提供',
					skin : 'layui-layer-demo', //样式类名
					closeBtn : 1, //不显示关闭按钮
					anim : 4, //动画类型
					shadeClose : true, //开启遮罩关闭
					area : [ '80%', '80%' ],
					maxmin : true, //开启最大化最小化按钮
					content : './view_sp.php' //iframe的url
				});
			})
		})

	})
</script>
</body>
</html>
