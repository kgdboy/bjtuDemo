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
	<title>修改密码--layui后台管理模板</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="../../frame/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="../../css/user.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form changePwd" method="post" id="form1">
		<div style="margin:0 0 15px 110px;color:#f00;"></div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户ID</label>
			<div class="layui-input-block">
				<input type="text" name="id" value="${ sessionScope.UserBean.id}" disabled class="layui-input layui-disabled">
			</div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">登陆名</label>
		    <div class="layui-input-block">
		    	<input type="text" value="${ sessionScope.UserBean.login_name}" disabled class="layui-input layui-disabled">
		    </div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">真实姓名</label>
			<div class="layui-input-block">
				<input type="text" value="${ sessionScope.UserBean.name}" disabled class="layui-input layui-disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">所在部门</label>
			<div class="layui-input-block">
				<input type="text" value="${ sessionScope.UserBean.depart_name}" disabled class="layui-input layui-disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">工资号码</label>
			<div class="layui-input-block">
				<input type="text" value="${ sessionScope.UserBean.salary_number}" disabled class="layui-input layui-disabled">
			</div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">旧密码</label>
		    <div class="layui-input-block">
		    	<input type="password" value="" placeholder="请输入旧密码" lay-verify="required|oldPwd" class="layui-input pwd" name="oldpwd">
		    </div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">新密码</label>
		    <div class="layui-input-block">
		    	<input type="password" value="" placeholder="请输入新密码" lay-verify="required|newPwd" id="oldPwd" class="layui-input pwd" name="newpwd">
		    </div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">确认密码</label>
		    <div class="layui-input-block">
		    	<input type="password" value="" placeholder="请确认密码" lay-verify="required|confirmPwd" class="layui-input pwd" name="newpwd_confirm">
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		    	<button class="layui-btn" lay-submit="" lay-filter="changePwd">立即修改</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	<script src="../../layui225/layui.js"></script>
	<script>
        layui.use(['layer','jquery','form'],function() {
            var layer = layui.layer,
                table = layui.table,
                form = layui.form,
                laydate = layui.laydate,
                $ = layui.$,
		        form = layui.form;
            form.on('submit(changePwd)', function(data){
                $.post('changePwd_ok.php',data.field,function (data) {
                    var data = $.parseJSON(data);
                    if (data.code==0){
                        layer.alert("密码修改成功,请牢记！",{
                            title:'用户id:'+data.id,
                            icon:1,
                            shift:3,
                            closeBtn:0
                        },function () {
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                            window.location.reload();
                            top.document.location.href='../../exit.php';
                        })

                    }else{
                        layer.alert("密码修改失败,失败原因为:<hr>"+data.message,{
                            icon:2,
                            shift:4,
                            area:['380px','200px']
                        })
                    }
                })
                return false;
            });

        })
	</script>
	<!--<script type="text/javascript" src="address.js"></script>-->
	<!--<script type="text/javascript" src="user.js"></script>-->
</body>
</html>