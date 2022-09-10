<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Túi xinh | Đăng ký</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<base href="${pageContext.servletContext.contextPath}/">
<style>
<%@ include file="/WEB-INF/css/register.css"%>
</style>

<style><%@include file="/WEB-INF/css/reset.css"%></style>
<script type="text/javascript" src="js/query.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap" rel="stylesheet">
</head>
<body>
	<form:form action="user/register.htm" name="register-form" method="post" modelAttribute="USER">
	<script type="text/javascript">
		if(${message == true}){
			alert("Đăng ký tài khoản thành công!");
		}
		if(${message == false}){
			alert("Đăng ký tài khoản không thành công!");
		}
	</script>
	<div class="gom">
	
		<p>ĐĂNG KÝ</p>
		<label for=""> Tên người dùng: </label> 
			<input type="text" name="account"> 
			<form:errors class="err" path="account"/>
			<br>
		<label for=""> Số điện thoại: </label> 
			<input type="text" name="phone"> 
			<form:errors class="err" path="phone"/>
			<br>
		<label for=""> Email: </label> 
			<input type="email" name="email"> 
			<form:errors class="err" path="email"/>
			<br>
		<label for=""> Địa chỉ: </label> 
			<input type="text" name="address"> 
			<form:errors class="err" path="address"/>
			<br>
		<label for=""> Mật khẩu: </label> 
			<input type="password" name="Pass"> 
			<form:errors class="err" path="Pass"/>
			<br>
		<label for=""> Xác nhận mật khẩu: </label> 
			<input type="password" name="pass_">
		<button>Đăng ký</button>
		<p>
			Tôi đã có tài khoản, <a href="user/login.htm?se=true" class="login-here">đăng nhập tại đây!</a>
		</p>
		
	</div>
	</form:form>
</body>
</html>
