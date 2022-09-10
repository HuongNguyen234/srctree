<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Thay đổi thông tin sản phẩm</title>
	<base href="${pageContext.servletContext.contextPath}/">
	<style><%@include file="/WEB-INF/css/update.css"%></style>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<script type="text/javascript" src="js/query.js"></script>
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap" rel="stylesheet">
</head>
<body>

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

    <div class="form d-flex">
        <form:form style = "margin-left: 30px;" action="" modelAttribute="prods" enctype="multipart/form-data" method="post">
            <c:if test="${message == true}">
            	<script type="text/javascript">
					alert("Cập nhật thành công!");
				</script>
            </c:if>
            <c:if test="${message == false}">
            	<script type="text/javascript">
					alert("Cập nhật không thành công!");
				</script>
            </c:if>
            <h1>Thay đổi thông tin sản phẩm</h1>
            <div>Mã sản phẩm:</div>
            	<form:input path="id" readonly="true" />
            <div>Tên sản phẩm:</div>
            	<form:input path="name" type="text"/>
            	<br>
            	<form:errors style = "color: red;"  class="err" path="name"/>
            	
            <div>Số lượng:</div>
            	<form:input path="inventory_number" type = "number" min="0"/>
            	<br>
            	<form:errors style = "color: red;" class="err" path="inventory_number"/>
            	
            <div>Giá:</div>
            	<form:input path="price"  type = "number"  min="0"/>
            	<br>
            	<form:errors class="err" style = "color: red;" path="price"/>
            <div>Loại:</div>
            	<form:select style="width: 520px;margin: 15px 0;border: #35b0ca solid 1px;padding: 10px;" path="categori.id" items="${type}" itemLabel="name" itemValue="id"/> 
            <div>Link ảnh:</div>
            	<input type="file" name="image"/>
            <div>Giới thiệu sản phẩm:</div>
            	<form:input path="detail" type="text"/>
            	<br>
            	<form:errors class="err" style = "color: red;" path="detail"/>
            <br>
             
            <button>Thay đổi</button>
            
        </form:form>
        <div class="table">
            <table>
                <tr>
                    <th>Hình ảnh sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Loại</th>
                    <th>Số lượng</th>
                    <th>Giá (VND)</th>
                </tr>
                <c:forEach var="p" items="${product}">
                <tr>
                    <td><img style="width: 100px;" alt="" src="image/${p.img}"></td>
                    <td>${p.name}</td>
                    <td>${p.categori.name}</td>
                    <td>${p.inventory_number}</td>
                    <td>${p.price}</td>
                </tr>
                </c:forEach>
                
            </table>
        </div>
    </div>
</body>
</body>
</html>