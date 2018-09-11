<%@ page language="java" import="java.util.*,bjtu.gruop7.bean.UserBean" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//判断session信息
	HttpSession sn = request.getSession();
	UserBean bean = (UserBean)sn.getAttribute("UserBean");	
	 if(bean==null){
		 response.sendRedirect(request.getContextPath() +"/login.html");
		 
	} 
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>会员添加--layui后台管理模板</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="../../frame/layui225/css/layui.css" media="all">
	<style type="text/css">
		.layui-form-item .layui-inline{ width:33.333%; float:left; margin-right:0; }
		@media(max-width:1240px){
			.layui-form-item .layui-inline{ width:100%; float:none; }
		}
	</style>
</head>
<body class="childrenBody">
	<form class="layui-form" style="width:80%;margin-top: 15px;">
		<div class="layui-form-item">
			<label class="layui-form-label">登录名 ：</label>
			<div class="layui-input-block">
				<input type="text" id="loginName" name="loginName" class="layui-input " lay-verify="required" placeholder="请输入登录名">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">登陆密码：</label>
			<div class="layui-input-block">
				<input type="password" id="firstPwd" name="firstPwd" class="layui-input " lay-verify="required" placeholder="请设置6位以上密码">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认密码：</label>
			<div class="layui-input-block">
				<input type="password" id="secondPwd" name="secondPwd" class="layui-input " lay-verify="required" placeholder="请确认以上密码">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">真实姓名：</label>
			<div class="layui-input-block">
				<input type="text" id="realName" name="realName" class="layui-input " lay-verify="required" placeholder="请输入真实姓名">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">所在部门：</label>
			<div class="layui-input-block">
				<select name="departmentName" lay-verify="required" lay-search>
					<option value="">选择部门</option>
					<?php foreach ($zrdw as $value) {?>
					<option value=<?php echo $value;?>><?php echo $value;?></option>
					<?php }?>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">选择职务：</label>
			<div class="layui-input-block">
				<select name="duty" lay-verify="required" lay-search>
					<option value="">选择职务</option>
					<?php foreach ($khr_zw as $value) {?>
					<option value=<?php echo $value;?>><?php echo $value;?></option>
					<?php }?>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">工资号码 ：</label>
			<div class="layui-input-block">
				<input type="text" id="salary_number" name="salary_number" class="layui-input " lay-verify="required|number" placeholder="请输入工资号">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">电话号码 ：</label>
			<div class="layui-input-block">
				<input type="text" id="phone_number" name="phone_number" class="layui-input " lay-verify="required|phone" placeholder="请输入电话号">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline" style="width: 100%;">
			    <label class="layui-form-label">用户权限 ：</label>
			    <div class="layui-input-block">
			      <!--各模块权限-->
					<div class="layui-unselect layui-form-checkbox layui-form-checked" lay-skin=""><span>普通用户</span><i class="layui-icon"></i></div>
					<input type="hidden" name="user[guest]" title="" value="0">
					<input type="checkbox" name="user[wtk]" title="问题库管理" value="4">
					<input type="checkbox" name="user[gbpj]" title="干部评价管理" value="3">
					<input type="checkbox" name="user[dcgl]" title="订餐管理" value="2" >
					<input type="checkbox" name="user[dbgl]" title="督办管理" value="5">
					<input type="checkbox" name="user[admin]" title="系统管理员" value="1">
			    </div>
		    </div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">允许登陆：</label>
			<div class="layui-input-block">
				<input type="checkbox" name="userState" lay-skin="switch" lay-text="ON|OFF" checked>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="addUser">立即注册</button>
				<button type="reset" class="layui-btn layui-btn-primary">全部重置</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="../../frame/layui225/layui.js"></script>
	<script>
		layui.use(['layer','element','form'],function () {
			var element  = layui.element,
				form = layui.form,
				layer = layui.layer,
				$ = layui.$;
				
			form.on('submit(addUser)',function (data) {
                //开始长度验证
                if(data.field.loginName.length<2){
                    layer.msg('登陆名长度不能小于2位');
                    return false;
                }
                if(data.field.firstPwd.length<6 || data.field.secondPwd.length<6){
                    layer.msg('密码长度不能小于6位');
                    return false;
                }

                if(data.field.firstPwd !== data.field.secondPwd){
                    layer.msg('两次密码不一致');
                    return false;
                }
                //真实姓名2位以上
                if(data.field.realName.length<2){
                    layer.msg('真实姓名不能小于2位');
                    return false;
                }
				//工资号码
                if(data.field.salary_number.length<7){
                    layer.msg('工资号码不能小于7位');
                    return false;
                }
                //手机号码
                if(data.field.phone_number.length!=11){
                    layer.msg('手机号码应为11位');
                    return false;
                }
                $.post('addUser_ok_ajax.php',data.field,function (data) {
                    var data = $.parseJSON(data);
                    if (data.code==0){
                        layer.alert("用户注册成功,请您牢记帐号密码！",{
                            title:'用户id:'+data.id,
                            icon:1,
                            shift:2,
                            closeBtn:0
                        },function () {
                            window.location.reload();
                        })
                    }else{
                        layer.alert("注册失败,失败原因为:<hr>"+data.message,{
                            icon:2,
                            shift:4,
                            area:['380px','200px']
                        })
                    }
                })
				return false;
            })
		})

	</script>

</body>
</html>