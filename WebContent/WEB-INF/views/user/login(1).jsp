<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
    <title>Đăng nhập</title>
	<base href = "${pageContext.servletContext.contextPath}/">
	<style><%@include file="/WEB-INF/css/login.css"%></style>
	<script type="text/javascript" src="js/login.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" />
</head>

<body>
	<form:form action="" modelAttribute="USER">
    <div class="login-box">
        <h1>Login</h1>
        ${message}
        <div class="textbox">
            <i class="far fa-user"></i>
            <input type="text" placeholder="Email" name="email" style="background-color: none;"/>
            
        </div>
		<br>
		<form:errors class="err" path="email" style = "color: red"/>
        <div class="textbox">
            <i class="fas fa-lock"></i>
            <input type="password" placeholder="Mật Khẩu" name="Pass" />
            
        </div>
		<br>
		<form:errors class="err" path="Pass" style = "color: red"/>
		
        <button class="btn">Đăng nhập</button>
        
        <p style="color: blue">
        	<a href="user/register.htm" class="dangKi">Đăng ký</a> 
        	<br>
        	<a href="user/forget-pass.htm" class="quen-pass">Quên mật khẩu?</a> 
        </p>
    </div>
    </form:form>
   
</body>
</html>