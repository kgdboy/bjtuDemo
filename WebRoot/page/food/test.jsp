<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>站段订餐系统</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="icon" href="favicon.ico">
<link rel="stylesheet" href="./frame/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="./css/main.css" media="all" />
</head>
<body>
	 <%-- ${requestScope.user}  接bean对象  等同于<%=request.getAttribute("user")%>--%>
  	<table border="1px solid #000">
  		<tr align="center">
				<td style="width:100px;height:30px;">1序号</td>
				<td style="width:100px;height:30px;">id</td>
		    	<td style="width:100px;height:30px;">姓名</td>
		    	<td style="width:100px;height:30px;">部门</td>
		    	<td style="width:100px;height:30px;">权限分组</td>
		</tr>
		<c:forEach items="${user}" var="rec" varStatus="status">

			<tr align="center">
				<td style="width:100px;height:30px;">${status.index+1} </td>
		    	<td>${rec.id}</td>
		    	<td>${rec.name}</td>
		    	<td>${rec.depart_name}</td>
		    	<td>${rec.depart_name}</td>
		    </tr>
		</c:forEach>
	</table>
</body>
</html>
