<%@ page language="java" import="java.util.*,bjtu.gruop7.bean.UserBean" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>个人资料</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">

	<link rel="stylesheet" href="../../frame/layui/css/layui.css" media="all" />

	<style>
		img{
			width: 200px;
			height: 200px;
		}
		.layui-input-inline{
			width: 100px;
		}

	</style>
</head>
<body class="childrenBody">
	<form class="layui-form">
		<div class="">
			<div class="layui-form-item">
			    <label class="layui-form-label">用户名</label>
			    <div class="layui-input-inline">
			    	<input type="text" value="${ sessionScope.UserBean.login_name}" disabled class="layui-input layui-disabled">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">用户组</label>
			    <div class="layui-input-inline">
			    	<input type="text" value="${ sessionScope.UserBean.lev}" disabled class="layui-input layui-disabled">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">真实姓名</label>
			    <div class="layui-input-inline">
			    	<input type="text" value="${ sessionScope.UserBean.name}" disabled lay-verify="required" class="layui-input realName layui-disabled">
			    </div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">所在部门</label>
				<div class="layui-input-inline">
					<input type="text" value="${ sessionScope.UserBean.depart_name}" disabled lay-verify="required" class="layui-input realName layui-disabled">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">职  务</label>
				<div class="layui-input-inline">
					<input type="text" value="${ sessionScope.UserBean.duty}" disabled lay-verify="required" class="layui-input realName layui-disabled">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">工资号码</label>
				<div class="layui-input-inline">
					<input type="text" value="${ sessionScope.UserBean.salary_number}" disabled lay-verify="required" class="layui-input realName layui-disabled">
				</div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">手机号码</label>
			    <div class="layui-input-inline">
			    	<input type="tel" disabled value="${ sessionScope.UserBean.tel}" placeholder="请输入手机号码" lay-verify="required|phone" class="layui-input userPhone layui-disabled">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">帐户状态</label>
			    <div class="layui-input-block userHobby">
					<div class="layui-unselect layui-form-checkbox layui-form-checked" lay-skin=""><span>注册用户</span><i class="layui-icon"></i></div>
					<div class="layui-unselect layui-form-checkbox layui-form-checked" lay-skin=""><span>允许登陆</span><i class="layui-icon"></i></div>
			    </div>
			</div>
		</div>
	</form>
	<script type="text/javascript" src="../../layui225/layui.js"></script>
	<script>
		layui.use(['element','layer','carousel'],function () {
		    var element = layui.element,
				layer = layui.layer,
                carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#test1'
                ,width: '100%' //设置容器宽度
				,height:'350px'
                ,arrow: 'none' //始终显示箭头
                ,anim: 'fade' //切换动画方式
				,indicator:'none'
            });
        })
	</script>
</body>
</html>