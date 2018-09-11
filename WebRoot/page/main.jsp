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
	<title>首页--后台管理模板</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="../frame/layui225/css/layui.css" media="all">
	<style>
		body{
			height:100%;
			background: url("../images/ycqbg.jpg") no-repeat;
			
			background-size: 100%;
		}
	</style>
</head>
<body>

<%-- ${ sessionScope.UserBean.name} 
${sessionScope.age}  
 --%>



</body>
</html>