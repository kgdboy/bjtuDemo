<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1px solid #000">
	<c:forEach items="${sessionScope.UserBean}" var="rec" varStatus="status">
    	<tr ondblclick="window.open('RwInfoServlet?id=${rec.id}', '_blank')">
    		<td align="center">${status.index + 1}</td>
    		<td align="center">${rec.name}</td>
    		<td><div class="odiv" title="<c:out value="${rec.info}"></c:out>">
<a href="RwInfoServlet?id=${rec.id}" target="_blank"><c:out value="${rec.info}"></c:out></a></div></td>
    		<td align="center"><c:out value="${rec.fqr}"></c:out></td>
    		<td align="center">${rec.unix}</td>
    	</tr>
    	</c:forEach>
   	</table>
</body>
</html>