<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Quản lý đơn hàng</title>
<base href="${pageContext.servletContext.contextPath}/">
<style><%@include file="/WEB-INF/css/manage_ord.css"%></style>
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
<div class="d-flex" style="width: 1350px">

	<div class="form">
	     <c:forEach var="o" items="${bill1}">
					<form:form action="ad/manage.htm?id=${o.id}" method="post">
					    <div class="order d-flex">
					        <div class="img">
					            <img src="image/${o.product.img}" alt="không có ảnh">
					        </div>
				        	<div class="infor">
					            <p>Mã đơn hàng: ${ o.id}</p>
					            <p>Tên sản phẩm: ${ o.product.name}</p>
						        <p>Tên khách hàng: ${o.user.account}</p>
							    <p>Số lượng: ${o.quanty}</p>
					            <p>Ngày đặt hàng: ${o.date}</p>
							    <p>Tổng tiền: ${o.price}</p>
					        </div>
					        <div class="but d-flex">
				                <button>Xác nhận</button>
<!-- 				                <button>Hủy</button>
 -->				            </div>
				        </div>
				   	</form:form>
			</c:forEach>
		

	</div>
	<div class="table">
	         <table>
             <tr>
                 <th>Mã đơn hàng</th>
                 <th>Số lượng</th>
                 <th>Ngày đặt</th>
                 <th>Tổng tiền</th>
                 <th>Trạng thái</th>
             </tr>
             
             
             	<c:forEach var="p" items="${bill0}">
             	<tr>
	                 <td>${p.id}</td>
	                 <td>${p.quanty}</td>
	                 <td>${p.date }</td>
	                 <td>${p.price}</td>
	                 <td><h4>Đã xác nhận</h4></td>
             	</tr>
         		</c:forEach>
         	
     	</table>
	</div>
</div>
</body>
</body>
</html>