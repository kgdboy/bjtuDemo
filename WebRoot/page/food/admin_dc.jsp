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
	<title>管理员充值</title>
</head>
<style>
	body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,button,textarea,p,blockquote,th { margin:0; padding:0; };
	.clearfix:after {content: "."; display: block; height:0; clear:both; visibility: hidden;}
	.clearfix { *zoom:1; }
	body{
		background:url("./img/admin_cz_bg.gif") repeat 0;
	}
	#wrap{
		width: 800px;
		margin: 50px auto;
		margin-bottom: 0;
	}
	#wrap #content{
		border:none;
		margin: 80px 0;
	}
	#content img {
		cursor: pointer;
	}
	.h{
		width: 120px;
		height: 33px;
	}
	option,span{
		margin-left:10px;
		font:16px/16px '微软雅黑';
	}
	#show_je{
		width: 100%;
		height: 150px;
		font:30px/150px '微软雅黑';
		margin: 50px auto;
		text-align: center;
		border:2px solid #000;
	}
	#show_je span{
		font:30px/150px '微软雅黑';
		color: red;
	}
	#je{
		width: 100px;
		height: 30px;
		text-align: center;
		font-size: 19px;
	}
</style>
<script src="./js/jquery-1.10.2.min.js"></script>
<script src="./js/layer.js"></script>
<script src="./bs3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./bs3/css/bootstrap.min.css">

<script>
	$(function () {
        //自执行方法
        //自执行方法
 	(function(){
		$(".ye").html(0);
            //${pageContext.request.contextPath} ${sessionScope.UserBean.orga_id}
            $.post("${pageContext.request.contextPath}/TestReturnDepartServlet",
                {
                    "orga_id":'${sessionScope.UserBean.orga_id}'
                },
                function(data){
                    var data = data.split(",");
                    $(".bm").remove();
                    for (var i=0;i<data.length;i++) {
                        if (data!="") {
                            $("#bm").append("<option class='bm' value="+data[i]+">"+"&nbsp;"+data[i]+"</option>");
                        };
                    };
                });
	})();
	//部门改变刷新人员
        $("#bm").change(function(){
        $("#salary_num").val("");//改变部门时清空工资号
        var bm = $("#bm").val();
        $(".ye").html(0);
        	 //${pageContext.request.contextPath} ${sessionScope.UserBean.orga_id}
            $.post("${pageContext.request.contextPath}/TestReturnNameServlet",
                {
                    "orga_id":'${sessionScope.UserBean.orga_id}',
                    "depart_name":bm
                },
                function(data){
                    var data = data.split(",");   
                    $(".o").remove();
                    for (var i=0;i<data.length;i++) {
                        if (data!="") {
                            $("#name").append("<option class='o' value="+data[i]+">"+"&nbsp;"+data[i]+"</option>");
                        };
                    };
                    
                });
        });
        //当用户选择人员时
         $("#name").change(function(){
         // 选择人员后添加工资号到隐藏域
         $("#salary_num").val($("#name").val().substr($("#name").val().indexOf('-')+1));
        
         var salary_num = $("#salary_num").val();
         console.log("'"+salary_num+"'");
         //${pageContext.request.contextPath} 
           $.post("${pageContext.request.contextPath}/RequestMoneyServlet",{"salary_number":salary_num},function(data){
                    $(".ye").html(JSON.parse(data).virtual_account);
                    $("#tid").val(JSON.parse(data)[0]);
           });
        }); 
        
        
        $("#dc").click(function () {
			//如果没有选择部门或人员或id未获取弹出错误提示。
            if(($('#bm').val()=="") || ($('#name').val()=="")){
                layer.alert("<span style='font-size: 15px;font-family: 微软雅黑;'>部门或人员选择错误</span>",{
                    icon:2,
                    title:'出错提示：',
                    skin: 'layui-layer-lan', //样式类名
                    anim:4
                })
                return false;
			}
            //如果没有获取到人员id，弹出错误提示。
            if(($('#tid').val()=="") || ($('#tid').val()==0)){
                layer.alert("<span style='font-size: 15px;font-family: 微软雅黑;'>人员id获取错误，请联系管理员。</span>",{
                    icon:2,
                    title:'出错提示：',
                    skin: 'layui-layer-lan', //样式类名
                    anim:4
                })
                return false;
            }
            //所有验证都通过之后，询问用户,用户确定后发送AJAX请求到admin_cz_ajax.php
			$("#bm").val()
            layer.confirm('确定为'+$("#bm").val()+$("#name").val()+'预订'+$("#cb").val()+'吗?', {
                title:'管理员订餐不受时间限制',
                icon:3,
                skin: 'layui-layer-molv',
                btn: ['确定','取消'] //按钮
            }, function(){
             	var salary_num = $("#salary_num").val();
                var je;
                var lb=$("#cb").val();
                //判断 金额
                switch($("#cb").val()){
                	case '晚餐':
                		je=6;
                		break;
                		default:
                		je=2;
                }
                //发送AJAX请求
                $.post("${pageContext.request.contextPath}/ReservationMealServlet",{
						"request_status":"订餐",
						"reservation_category" :lb,
						"salary_number":salary_num
                },function(data){
                    var data = JSON.parse(data);
                    if(data.code==1){
                        layer.alert(data.message, {
                            title:'很遗憾的提示您：',
                            icon: 2,
                            skin: 'layui-layer-molv'
                        });
                    }else if(data.code==0){
                        layer.alert('恭喜您,订餐成功了。', {
                            title:'本次订餐后,您的余额为：'+data.virtual_account+'元',
                            icon: 1,
                            skin: 'layui-layer-molv'
                        });
                        //修改页面显示余额,否则无法进行同一人的二次充值
						$(".ye").html(data.virtual_account);
                    }
                });
            });
        })
    })
</script>
<body>
<div id="wrap" class="clearfix">
	<div id="title_gif">
		<img src="./img/admin_dc.png" alt=""/>
	</div>
	<div id="content">
		<div>
			<span>选择部门：</span>
			<select  name="bm" id="bm" class="h">
				<option value="">请选择</option>
			</select>
			<!--加载后的人员-->
			<span>确定人员：</span>
			<select class="h" name="name" id="name"  >
				<option value="">请选择</option>
			</select>
			<span>餐别：</span>
			<select class="h" name="cb" id="cb"  >	
				<option value="早餐">早餐</option>
				<option value="午餐">午餐</option>
				<option value="晚餐">晚餐</option>
			</select>
			<input type="button" style="width: 80px;margin-left: 10px;" class="btn btn-success" value="订餐" id="dc">

		</div>
		<div id="show_je">
			该用户帐户余额为：<span class="ye">0</span> 元
		</div>

		<input type="hidden" name="salary_num" id="salary_num">
	</div>
</div>
</body>
</html>