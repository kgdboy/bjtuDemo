layui.config({
	base : "js/"
}).use(['form','layer','jquery'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
	//video背景
	$(window).resize(function(){
		if($(".video-player").width() > $(window).width()){
			$(".video-player").css({"height":$(window).height(),"width":"auto","left":-($(".video-player").width()-$(window).width())/2});
		}else{
			$(".video-player").css({"width":$(window).width(),"height":"auto","left":-($(".video-player").width()-$(window).width())/2});
		}
	}).resize();

	//登录按钮事件
	form.on("submit(login)",function(data){
		// 发起AJAX请求
		$.post('SignInServlet',data.field,function(data){
        // 判断第一个字符是否非法
		var firstCode = data.charCodeAt(0);
		if (firstCode < 0x20 || firstCode > 0x7f) {
			data = data.substring(1); // 去除第一个字符
		}
            data = $.parseJSON(data);
            console.log(data);
	    if (data.code==0){
	    	layer.msg("欢迎 <span style='color:green;'>"+data.bm+' '+data.name+"</span> 登陆系统",{
                        title:'欢迎登陆',
                        icon:1,
                        shift:4,
                        time:1000
                    },function () {
						window.location.href = "index.jsp";
                    })
	    }else{
	    	layer.alert("登陆失败,"+data.message,{
	            icon:2,
	            shift:6,
	        })
	    }
	})
	return false;
	})
	$(function () {

        var a = Math.round(Math.random(0,1)*5,0);
        var b = Math.round(Math.random(0,1)*4,0);
        var c= a+b;
        $(".yzm").text(a + "+" + b + "= ?");
        $("#yzm_rzt").val(c);
        $(".yzm").click(function () {
            a = Math.round(Math.random(0,1)*5,0);
            b = Math.round(Math.random(0,1)*4,0);
            c= a+b;
            $(".yzm").text(a + "+" + b + "= ?");
            $("#yzm_rzt").val(c);
        })

    })
})
