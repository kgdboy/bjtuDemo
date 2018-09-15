<%@ page language="java" import="java.util.*,bjtu.gruop7.bean.UserBean"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//判断session信息
	HttpSession sn = request.getSession();
	UserBean bean = (UserBean) sn.getAttribute("UserBean");
	if (bean == null) {
		response.sendRedirect(request.getContextPath() + "/login.html");
	}
	String lev = bean.getLev();
	//当前订餐管理页面权限为2
	String num = "2";
	Boolean ACC = false;
	//如果用户等级里没有2则退出
	String[] strings = lev.split(",");
	String n1 = strings[0];

	for (int i = 0; i < strings.length; i++) {
		if ("1".equals(strings[i]) || num.equals(strings[i])) {
			ACC = true;
		}
	}
	if (!ACC) {
		response.sendRedirect(request.getContextPath() + "/page/error.html");
	}
%>
<!DOCTYPE html>
<html>
	<head>
	<body>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>日志查询</title>

	<link rel="stylesheet" href="./layui/css/layui.css" media="all">
	</head>
	<style>
	body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,button,textarea,p,blockquote,th { margin:0; padding:0; };
	.clearfix:after {content: "."; display: block; height:0; clear:both; visibility: hidden;}
	.clearfix { *zoom:1; }
	body{
		background:url("./img/logbg.png") no-repeat;
		background-size: 100%;
	}
	#wrap{
		width: 1250px;
		margin: 50px auto;
		margin-bottom: 0;
	}
	#title_gif{
		width: 900px;
		margin: 0 auto;
	}
	.s{
		font-size: 22px;
		font-family: "微软雅黑", Verdana;
		color:#000;
	}
	#cx_date{
		width: 240px;
	}
	#cx_name{
		width: 140px;
	}
	.layui-input{
		width: 140px;
		text-align: center;
	}
	.layui-input-inline{
		margin:0 10px;
		text-align: center;
	}
	#ok{
		width: 120px;height: 40px;font-size: 19px;font-family: "微软雅黑", Verdana;
	}
</style>
	<div id="wrap">
		<div id="title_gif">
			<img src="./img/bghead.gif" alt=""/>
		</div>
		<hr class="layui-bg-green">
		<form  method="post" class="layui-form" id="form1">
			<table width=90% height=50px cellspacing="0" cellpadding="2" align="center">
				<tr>
					<td align="center">
						<div class="layui-input-inline">
							<span class="s">日期查询:</span>
						</div>
						<div class="layui-input-inline">
							<input type="text" name="dc_date" autocomplete="off" placeholder="请选择日期区间" class="layui-input" id="cx_date" lay-key="1">
						</div>
						<div class="layui-input-inline">
							<span class="s">用户查询:</span>
						</div>
						<div class="layui-input-inline">
							<input type="text" name="name" autocomplete="off" placeholder="请输入用户名" class="layui-input" id="cx_name" lay-key="1" >
						</div>
						<div class="layui-input-inline">
							<span class="s">查询类别:</span>
						</div>
						<div class="layui-input-inline">
							<!--select-->
							<select name="cx_lb" >
								<option value=""> 请选择</option>
								<option value="消费">消费</option>
								<option value="退费">退费</option>
								<option value="充值">充值</option>
								<option value="其它">其它</option>
							</select>
						</div>
						<!--隐藏域 -->
						<input type="hidden" name="orga_id" value="${sessionScope.UserBean.orga_id}"/>
						<input type="button" value="查询" class="layui-btn layui-btn-radius" lay-submit lay-filter="cx" id="ok" name="ok"/>
					</td>
				</tr>
			</table>
			
		</form>
		<hr class="layui-bg-green">
		<table id="test1" lay-filter="test" lay-data="idTest"></table>
	</div>
</body>
	<script src="layui/layui.js"></script>
	<script>
        layui.use([ 'layer', 'jquery', 'laydate', 'table','form' ], function() {
            var layer = layui.layer,
                form = layui.form,
                laydate = layui.laydate,
				table = layui.table,
                $ = layui.$;
            //执行一个laydate实例
            laydate.render({
                elem : '#cx_date' //指定元素
                ,range: '~'
				,value: new Date().getFullYear() + "-" + (new Date().getMonth()) + "-" + new Date().getDate()+" ~ "+ new Date().getFullYear() + "-" + (new Date().getMonth()+1) + "-" + new Date().getDate()
				,max:0
                ,calendar: true
        	});
            form.on('submit(cx)',function (data) {
                var tt=null;
                tt = table.render({
                    elem: '#test1'//是真实ID
                    , width: 1250
                    ,where:data.field
                    , id: 'idTest'
                    , url: '${pageContext.request.contextPath}/TestLogServlet' //数据接口OperationLogServlet
                    , page: {theme: '#527B81', groups: 5, limit: 10, prev: '前一页', next: '下一页'} //开启分页
                    , limits: [15, 25, 35, 45, 55, 65, 75]//选择第多少页
                    , method: 'post'//传输方式
                    , cols: [[ //表头
                          {field: 'id', title: '序号', width: 100, sort: true, fixed: 'left', type: 'numbers'}
                        , {field: 'name', title: '姓名', align: 'center', id: 'message',width: 120}
                        , {field: 'log_date', title: '日期', width:200, align: 'center',sort:true}
                        , {field: 'log_category',title: '操作类别',width: 120,align: 'center'}
                        , {field: 'log_content',title: '操作形为',align: 'center'}
                    ]],
                    even:true,  //是否开启隔行换色
                    size:'lg' //表格大小控制
                });
            });
        })
	</script>
</html>
