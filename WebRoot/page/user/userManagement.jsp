<%@ page language="java" import="java.util.*,bjtu.gruop7.bean.UserBean" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			//判断session信息
		HttpSession sn = request.getSession();
		UserBean bean = (UserBean)sn.getAttribute("UserBean");	
		if(bean==null){
			 response.sendRedirect("./login.html");
		}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>首页--layui后台管理模板</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="../../frame/layui225/css/layui.css" media="all">
	<style>
		.zdy{
			height: 50px;
			margin-top:5px;
		}
		#jcr{
			width: 120px;
		}
		.row{
			padding:5px 0;
		}
		.layui-input{
			width: 150px;
			text-align: center;
		}
		.layui-form-label{
			font-family: "微软雅黑", Verdana;
			font-size: 15px;
			text-align: center;
			padding:9px 5px 9px 5px;
			width:70px;
		}
		.recommend{
			width: 80px;
		}

		#page{
			margin-top: -10px;
		}
	</style>
</head>
<body class="childrenBody">
<form class="layui-form" id="form1" method="post" >
<blockquote class="layui-elem-quote zdy">
	<div class="layui-block row">
		<!--1行1 用户名-->
		<div class="layui-inline" >
			<label class="layui-form-label">登陆名称</label>
			<div class="layui-input-inline">
				<input type="text" name="loginName"   class="layui-input" id="loginName" />
			</div>
		</div>
		<!--1行2 真实姓名-->
		<div class="layui-inline" >
			<label class="layui-form-label">真实姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="realName"   class="layui-input" id="realName" />
			</div>
		</div>
		<!--一行三 所在部门
		<div class="layui-inline" >
			<label class="layui-form-label">所在部门</label>
			<div class="layui-input-inline">
				<select name="Department" id="Department" lay-search>
					<?php foreach ($lev==1?$zrdw:$my_zrdw as $key=>$value) {?>
					<option value=<?php echo $value;?>><?php echo $value;?></option>
					<?php }?>
				</select>
			</div>
		</div>-->
		<!--一行四 电话号码-->
		<div class="layui-inline" >
			<label class="layui-form-label">电话号码</label>
			<div class="layui-input-inline">
				<input type="text" name="tel"   class="layui-input" id="tel" />
			</div>
		</div>
		<!--一行四 工资号码-->
		<div class="layui-inline" >
			<label class="layui-form-label">工资号码</label>
			<div class="layui-input-inline">
				<input type="text" name="gz_number"   class="layui-input" id="gz_number" />
			</div>
		</div>
		<div class="layui-inline">&nbsp;&nbsp;
			<div class="layui-input-inline">
				<a class="layui-btn recommend" style="background-color:#5FB878" lay-submit lay-filter="query">查询</a>
				<input class="layui-btn recommend" type="reset" style="background-color:#1E9FFF"></a>
			</div>
		</div>
	</div>
</blockquote>
</form>
<div id="page">
	<table id="test1" lay-filter="test" lay-data="idTest"></table>
</div>
<script type="text/javascript" src="../../frame/layui225/layui.js"></script>
<script>
    layui.use(['layer','jquery','table','form'],function() {
        var layer = layui.layer,
            table = layui.table,
            form = layui.form,
            $ = layui.$;

    //    监听查询
		form.on('submit(query)',function (data) {
		    var tt=null; //定义全局变量，为了能在修改数据后自动重载表格数据
            tt = table.render({
                id: 'idTest',
                elem:'#test1', //绑定表格id
                url:'userManagement_query_ok.php', //定义数据接口，默认传2个值，一个是page,一个是limit
                where:data.field,
                method:'post',
                height: 'full-130',
                page:{theme:'#e78',groups:10,limit:20,prev:'前一页'
                    ,next:'后一页'}, //定义分页效果
                limits:[10,20,30,40,50,60,70,80,90,100],
                cols:[[ //定义表头样式
                    {checkbox: true,fixed:'left',LAY_CHECKED:false}
                    ,{field: 'id', title: 'ID', width:60, sort: true, fixed: 'left',align:'center',unresize:true,templet:'<div><a href="javascript:;" class="layui-table-link" onclick=layer.open({type:2,title:"人员详情",area:["500px","550px"],btn:["关闭"],content:"userInfo.php"})>{{d.id}}</a></div>'}
                    ,{field: 'user', title: '登陆名', width:120, fixed: 'left',align:'center'}
                    ,{field: 'name', title: '姓名',width:115,sort: true,fixed: 'left',align:'center'}
                    ,{field: 'pass', title: '密码', width:100, fixed: 'left',align:'center'}
                    ,{field: 'bm', title: '部门', width: 150,align:'center',sort: true}
                    ,{field: 'zw', title: '职务', width: 120,align:'center',sort: true}
                    ,{field: 'lev', title: '权限', width:100,align:'center'}
                    ,{field: 'vmoney', title: '余额', width:70,align:'center'}
                    ,{field: 'gz_number', title: '工资号码', width:100,align:'center'}
                    ,{field: 'tel', title: '手机号码', width: 130,align:'center'}
                    ,{field: 'isdel', title: '状态', width:70,align:'center'}
                    ,{title: '操作', align:'center', toolbar: '#barDemo',width:200} //这里的toolbar值是模板元素的选择器
                ]],
                done:function (res, curr, count) {
                },
                even:0,  //是否开启隔行换色
                size:'md' //表格大小控制
            })
			//监听操作按钮
            table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if(layEvent === 'detail'){ //查看
                    layer.open({
                        type:2,
                        title:'用户信息',
                        area:['500px','550px'],
                        closeBtn:1,
                        btn:['关闭'],
                        shadeClose:1,
                        maxmin:true,
                        content:'userInfo.php'
                    })
                }else if(layEvent === 'edit'){ //整改
                    var cs = 0;
                    var index = layer.open({
                        type:2,
                        title:'用户信息修改',
                        area:['1150px','600px'],
                        shade: [0.8, '#393D49'],
                        closeBtn:1,
                        fixed:1, //固定可视区
                        btn:['关闭'],
                        content:'ModifyUser.php?id='+data.id,
                        yes:function () {
                            cs=1;
                            layer.close(index);
                        },
                        cancel:function () {
                            cs=1;
                            layer.close(index);
                        },
                        end:function () {
                            if (cs==0){
                                tt.reload();
                            }
                        }
                    })

                } else if(layEvent === 'del'){ //删除
                    layer.confirm('真的要删除这条数据吗？', function(index){
                        //向服务端发送删除指令
                        $.post("del_wtk_data_ajax.php",{'id':data.id},function (data) {
                            if (data=='yes'){
                                layer.msg('删除成功',{icon:1});
                                obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                layer.close(index);
                                //todo 此处应该把删除操作记录到日志中
                            }else{
                                layer.msg('删除失败',{icon:2});
                            }
                        })
                    });
                }
            });
           
            $("#barDemo").html(wg);
        })
    })
</script>
<script type="text/html" id="barDemo">
</script>
</body>
</html>