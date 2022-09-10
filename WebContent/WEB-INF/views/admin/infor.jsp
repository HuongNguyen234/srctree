<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Thông tin người dùng</title>
	<base href="${pageContext.servletContext.contextPath}/">
    <style><%@include file="/WEB-INF/css/infor.css"%></style>
	<script type="text/javascript" src="js/query.js"></script>
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="container d-flex">
            <div class="logo">
                <a href="">
                    <img src="image/logo_sab.png" alt="không có ảnh">
                </a>
            </div>
            <div class="login_search_contact">
                <div class="login_search d-flex">
                    <div class="search d-flex">
                        <input type="search" id="search" placeholder="search...">
                        <i class="fas fa-search"></i>
                    </div>
                    <div class="login d-flex">
	                    <a href="user/login.htm">Đăng xuất</a>
                    </div>
                </div>
                <div class="contact d-flex">
                    <div class="phone_num d-flex">
                        <i class="fas fa-mobile-alt"></i>
                        <a href="">+(84)979797979</a>
                    </div>
                    <div class="mail">
                        <i class="far fa-envelope"></i>
                        <a href="https://mail.google.com/">Sablanca@gmail.com</a>
                    </div>
                    <div class="address">
                        <i class="fas fa-map-marker-alt"></i>
                        <a href="https://maps.google.com/">Chỉ đường</a>
                    </div>
                </div>
            </div>
        </div>
    </header>
  <div class="title">
        <div class="container d-flex">
            <div class="navbar">
                <ul class="d-flex">
                    <li><a href="user/home.htm">Trang chủ</a></li>
                    <li><a href="user/about.htm">Thông tin</a></li>
                    <li class="dropdown d-flex">
                        <a href="user/product.htm">
                            Tất cả sản phẩm
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <ul class="menu-sh">
                            <li><a href="">Marc Jacobs</a></li>
                            <li><a href="">Louis Vuitton</a></li>
                            <li><a href="">Hermes</a></li>
                            <li><a href="">Burberry</a></li>
                            <li><a href="">Gucci</a></li>
                            <li><a href="">Parada</a></li>
                            <li><a href="">Vascara</a></li>
                            <li><a href="">Charles & Keith</a></li>
                            <li><a href="">Balenciaga</a></li>
                        </ul>
                    </li>
                    <li><a href="user/contact.htm">Liên hệ</a></li>
                </ul>
            </div>
            <div class="cart">
                <a href="user/cart.htm" class="d-flex">
                    <i class="fas fa-cart-arrow-down"></i>
                    <p>Cart: <span>0</span> product</p>
                </a>
            </div>
        </div>
    </div>
    <div class="infor">
        <div class="container d-flex">
            <form:form action="user/infor.htm" modelAttribute="infor">
            <h1>Chỉnh sửa</h1>
                <div>Tên tài khoản:</div>
                <input type="text" name="username"/>
                <div>Họ và tên:</div>
                <input type="text" name="fullname"/>
                <div>Số điện thoại:</div>
                <input type="text" name="phone"/>
                <div>Địa chỉ:</div>
                <input type="text" name="address"/>
                <div>Email:</div>
                <input type="text" name="email"/>
                <div>Mật khẩu:</div>
                <input type="text" name="password"/>
                <br>
                <button>Lưu thông tin</button>
                ${message}
            </form:form>
            <div class="infor-f">
		        <h1>Thông tin người dùng</h1>
		        
		        <div>Tên tài khoản: <a>{inf.getUsername()}</a></div>
		        
		        <div>Họ và tên: <a>{inf.fullname}</a></div>
		
		        <div>Số điện thoại: <a>{inf.phone}</a></div>
		
		        <div>Địa chỉ: <a>{inf.address}</a></div>
		
		        <div>Email: <a>{inf.email}</a></div>
		
		    </div>
        </div>
    </div>
    
</body>
</html>