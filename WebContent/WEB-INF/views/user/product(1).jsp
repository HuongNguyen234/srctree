<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Sablanca | Sản phẩm</title>
	<base href="${pageContext.servletContext.contextPath}/">
	<style><%@include file="/WEB-INF/css/product.css"%></style>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<script type="text/javascript" src="js/query.js"></script>
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap" rel="stylesheet">
 	<script src="<c:url value="https://code.jquery.com/jquery-3.5.1.min.js" />"></script>
	<script src="js/query.js"></script>

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
                        <input type="search" id="search" onkeyup="myFunction()" placeholder="Search for names..">
                        <i class="fa fa-search"></i>
                        <ul id="myUL" class="none">
	                        <c:forEach var="t" items="${product}">
	                        	<li><a href="user/show.htm?code=${t.id}">${t.name}</a></li>
	                        </c:forEach>
                        </ul>
                    </div>
                    <div class="login d-flex">
                        <c:if test="${sessionScope.username == null}">
                        
	                    		<a href="user/login.htm?se=true">Đăng nhập</a>
	                        	<a href="user/register.htm">Đăng ký</a>
                        
                        </c:if>
                        <c:if test="${sessionScope.username != null}">
                        
	                    		<a href="user/infor.htm">${sessionScope.username}</a>
	                        	<a href="user/login.htm?se=false">Đăng xuất</a>
                        
                        </c:if>
                    </div>
                </div>
                <div class="contact d-flex">
                    <div class="phone_num d-flex">
                        <i class="fa fa-mobile"></i>
                        <a href="">+(84)855556086</a>
                    </div>
                    <div class="mail">
                        <i class="fa fa-envelope"></i>
                        <a href="https://mail.google.com/">Sablanca@gmail.com</a>
                    </div>
                    <div class="address">
                        <i class="fa fa-map-marker"></i>
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
                            <i class="fa fa-chevron-down"></i>
                        </a>
                        <ul class="menu-sh">
                            <c:forEach var="t" items="${type}">
                            	<li><a href="user/${t.id}.htm?code=${t.id}">${t.name}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="cart">
                <a href="user/cart.htm?se=true" class="d-flex">
                    <i class="fa fa-cart-arrow-down"></i>
                    <p>Giỏ: <span>${count}</span> Sản phẩm</p>
                </a>
            </div>
        </div>
    </div>
    
    <div class="main">
        <div class="container d-flex">

            <div class="prods">
                <div class="title2">
                    <div class="flex d-flex">
                        <div class="navbar">
                            <ul class="d-flex">
                             <c:forEach var="t" items="${type}">
                            	<li><a href="user/${t}.htm?code=${t}">${t.name}</a></li>
                            </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="items d-flex">
                    <c:forEach var="item" items="${product}">
						<div class="item1">
							<img src="image/${item.img}" alt="Khong co anh">
							<p>${item.name}: <span>${item.price}</span></p>
							<a href="user/show.htm?code=${item.id}" class="buy">Mua ngay!</a>
						</div>
					</c:forEach>
                </div>
            </div>
        </div>
    </div>
    
   <div class="content">
        <div class="container">
            <div class="customer d-flex">
                <ul>
                    <h1>Hỗ trợ khách hàng</h1>
                    <li><i class="fa fa-hand-point-right"></i><a href="uer/about.htm">Chính sách bảo hành</a></li>
                    <li><i class="fa fa-hand-point-right"></i><a href="">Chính sách đổi trả</a></li>
                    <li><i class="fa fa-hand-point-right"></i><a href="">Phương thức thanh toán</a></li>
                    <li><i class="fa fa-hand-point-right"></i><a href="">Hướng dẫn đặt hàng</a></li>
                </ul>
                <ul>
                    <h1>Thông tin liên hệ</h1>
                    <li>Địa chỉ: 12 Nguyễn Trãi, phường 8, quận 3, tp Hồ Chí Minh</li>
                    <li>Số điện thoại: +84855556086</li>
                    <li>Thời gian làm việc: từ 9:00 đến 22:00</li>
                    <li>Website: Sablanca.com</li>
                    <li>Email: Sablanca@gmail.com</li>
                    <li>
                    	<a href="">
                    		<i class="fa fa-facebook"></i>
                    	</a>
                    	<a href="">
                    		<i class="fa fa-instagram"></i>
                    	</a>
                    	<a href="">
                    		<i class="fa fa-twitter"></i>
                    	</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>