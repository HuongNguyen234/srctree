<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>Index</title>
	<base href = "${pageContext.servletContext.contextPath}/">
</head>
<body>
	<table class ="table table-hover">
		<tr>
			<th>Username</th>
			<th>Password</th>
		</tr>
		<c:forEach var="u" items="${Product}"> 
			<tr>
				<td>${u.name}</td>
				<td>${u.price}</td>
				<td><a href="user/delete/${u.username}.htm">Delete</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>