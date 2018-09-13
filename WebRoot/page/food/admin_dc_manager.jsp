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
<!-- html开始  -->
<!DOCTYPE html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>管理员界面</title>
  <link rel="stylesheet" href="./layui/css/layui.css" media="all">

</head>
<style>
  body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code,
  form, fieldset, legend, input, button, textarea, p, blockquote, th {
    margin: 0;
    padding: 0;
  }
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
    /* background: url("./img/yzgs_bg.gif") repeat 0; */
  }
  #wrap {
    width: 900px;
    margin: 20px auto;
    margin-bottom: 0;
  }
  #wrap #content {
    border: none;
    width: 900px;
    margin: 10px 0;
  }
  #content img {
    cursor: pointer;
  }

  .h {
    width: 80px;
    height: 33px;
  }

  option, span {
    margin-left: 5px;
    font: 19px/19px '微软雅黑';
  }
  #show_block {
    margin-top: 50px;
    font: 19px/30px '微软雅黑';
    text-align: left;
    letter-spacing: 5px;
  }

  #show_block div {
    padding: 20px 0;
    text-align: left;
  }

  #je {
    width: 100px;
    height: 30px;
    text-align: center;
    font-size: 19px;
  }
  #title_gif img{
    width:900px;
  }
  #dc_date{
    font-size: 19px;
    text-align: center;
    width: 140px;
    color:#1E9FFF;
  }

  .layui-select-title{
  	width:140px;
  }
</style>

<body>
<div id="wrap" class="clearfix">
  <div id="title_gif">
    <img src="./img/admin_dc_manager.png" alt="" />
  </div>
  <div id="content">
    <form class="layui-form" id="form1" method="post" >

      <div class="layui-inline" >
        <input type="button" style="width: 100px;" class="layui-btn layui-bg-cyan" value="请选择日期 :">
        <div class="layui-input-inline">
          <input type="text" name="dc_date"  autocomplete="off"  placeholder="格式：yyyy-mm-dd"  class="layui-input" id="dc_date" >
        </div>
      </div>

      <div class="layui-inline" >
        <input type="button" style="width: 100px;" class="layui-btn layui-bg-cyan" value="请选择类别 :">
        <div class="layui-input-inline">
          <!--select-->
          <select name="dc_lb" lay-verify="required" id="dc_lb" style="width:100px">
            <option value="早餐">早餐</option>
            <option value="午餐">午餐</option>
            <option value="晚餐">晚餐</option>
          </select>
        </div>
        <input type="button" style="width: 90px;" class="layui-btn layui-bg-green" value="订餐查询" id="dc_cx">
        <!--订餐查询-->
      <input type="button" style="width: 90px;" class="layui-btn layui-bg-red" value="退餐管理" id="tc_cx">
      <input type="button" style="width: 90px;" class="layui-btn layui-bg-blue" value=" 菜谱维护 " id="cp">
      <input type="button" style="width: 90px;" class="layui-btn layui-bg-orange" value="后台订餐" id="admin_dc">

      </div>
     

      
    </div>
     <hr style="height: 3px;background: #009688;">
    <div id="show_block">
      <div class="b1"></div>
      <div class="b2"></div>
      <div class="b3"></div>
    </div>
  </div>
</body>
<script src="./layui/layui.js"></script>
<script>
    layui.use([ 'layer', 'jquery', 'laydate', 'form' ], function() {
        var layer = layui.layer,
            form = layui.form,
            laydate = layui.laydate,
            $ = layui.$;
        //执行一个laydate实例
        laydate.render({
            elem : '#dc_date' //指定元素
        });
        $("#dc_date").val(new Date().getFullYear() + "-" + (new Date().getMonth()+1) + "-" + new Date().getDate());
        $("#cx").click(function() {
            //发送ajax请求
            $.post("admin_dccx_ajax.php", {
                year : $("#year").val(),
                month : $("#month").val(),
                day : $("#day").val(),
                cb : $("#cb").val()
            }, function(result) {
                //                console.log(result);
                var code = JSON.parse(result);
                //                console.log(code);
                $(".b1").html($("#year").val() + '年' + $("#month").val() + '月' + $("#day").val() + '日' + '预订' + "<b style='text-align: center;color:red';>" + $("#cb").val() + "</b>" + '的总人数为: ' + code[0] + ' 人。').css('border-bottom', '3px solid red');
                $(".b2").html('<b style="text-align: center;color:blue;">各部门订餐情况如下</b> <br/><br/>' + code[1]).css('border-bottom', '3px solid red');
                $(".b3").html('<b style="text-align: center;color:blue;">各部门订餐人员如下</b> <hr>' + code[2]).css('border-bottom', '3px solid red');

            });
        })
        $("#admin_dc").click(function() {
            window.location.href = './admin_dc.php';
        })
        $("#tc").click(function() {
            window.location.href = './admin_tf.php';
        })

    })
</script>
</html>
<!--html结束  -->
