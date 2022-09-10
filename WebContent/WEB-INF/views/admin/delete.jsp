<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Xóa sản phẩm</title>
	<base href="${pageContext.servletContext.contextPath}/">
	<style><%@include file="/WEB-INF/css/delete.css"%></style>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<script type="text/javascript" src="js/query.js"></script>
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap" rel="stylesheet">
</head>
<body>
<header>
    <div class="container d-flex">
        <div class="logo">
            <a href="ad/home.htm">
                <img src="image/logo_sab.png" alt="không có ảnh">
            </a>
        </div>
        <div class="login_search_contact">
            <div class="login_search d-flex">
                <div class="search d-flex">
                    <input type="search" id="search" placeholder="search...">
                    <i class="fa fa-search"></i>
                </div>
                <div class="login d-flex">
					<a href="user/infor.htm">Admin</a>
						<a href="user/login.htm?se=false">Đăng xuất</a>
                </div>
            </div>
            <div class="contact d-flex">
                <div class="phone_num d-flex">
                    <i class="fa fa-mobile"></i>
                    <a href="">+(84)979797979</a>
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
              <li><a href="ad/delete.htm">Xóa, Sửa sản phẩm</a></li>
              <li><a href="ad/add_prod.htm">Thêm sản phẩm</a></li>
              <li><a href="ad/manage.htm">Quản lý đơn hàng</a></li>
              <li><a href="ad/tk.htm">Thống kê</a></li>
             </ul>
        </div>
    </div>
    </div>
<div class="del d-flex">

    <div class="table">
        <table>
            <tr>
                <th>Hình ảnh sản phẩm</th>
                <th>Mã sản phẩm</th>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Giá (VND)</th>
                <th></th>
            </tr>
            <c:forEach var="p" items="${product}">
             <form:form action="ad/delete.htm?codedel=${p.id}" method="post">
              <tr>
                  <td><img style="width: 100px;" alt="" src="image/${p.img}"></td>
                  <td>${p.id}</td>
                  <td>${p.name}</td>
                  <td>${p.inventory_number}</td>
                  <td>${p.price}</td>
                  <td>
	                  <button>Xóa</button> 
	                  
	                  <a href="ad/update.htm?codeUpdate=${p.id}">Sửa</a>
                  </td>
              </tr>
     		</form:form>
            </c:forEach>
            <c:if test="${message1 == true}">
            	<script type="text/javascript">
					alert("Xóa thành công!");
				</script>
            </c:if>
            <c:if test="${message1 == false}">
            	<script type="text/javascript">
					alert("Xóa không thành công!");
				</script>
            </c:if>
            
        </table>
    </div>
</div>
</body>
</html>