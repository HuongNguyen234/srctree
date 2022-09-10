<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<title>Sablanca | Trang chủ</title>
	<base href="${pageContext.servletContext.contextPath}/">
	<style><%@include file="/WEB-INF/css/style.css"%></style>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<style><%@include file="/WEB-INF/css/reset.css"%></style>
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
                        
	                        	<a href="user/login.htm">Đăng xuất
	                        	
	                        	</a>
                        
                        </c:if>
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
    <div class="show">
        <div class="container">
            <div class="poster d-flex">
                <img
                    src="https://www.chanel.com/images//t_fashion//q_auto,f_jpg,fl_lossy,dpr_2/w_620/classic-handbag-green-black-sequins-gold-tone-metal-sequins-gold-tone-metal-packshot-default-a01112b04832nb248-8832557842462.jpg">
                <div class="text right">
                    <h3>CHANNEL</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Reiciendis, sequi modi, quidem sit
                        libero
                        quas voluptates dicta sed alias iusto repellendus, ex voluptatibus! Perferendis molestiae
                        quisquam
                        sint quia vero. Hic!
                        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Labore commodi soluta vero sequi,
                        veritatis unde voluptates libero voluptatem accusamus, rem corporis optio. Quidem suscipit dicta
                        molestias possimus. Recusandae, officiis excepturi.
                    </p>
                </div>
            </div>
            <div class="poster d-flex">
                <div class="text left">
                    <h3>GUCCI</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Reiciendis, sequi modi, quidem sit
                        libero
                        quas voluptates dicta sed alias iusto repellendus, ex voluptatibus! Perferendis molestiae
                        quisquam
                        sint quia vero. Hic!
                        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Labore commodi soluta vero sequi,
                        veritatis unde voluptates libero voluptatem accusamus, rem corporis optio. Quidem suscipit dicta
                        molestias possimus. Recusandae, officiis excepturi.
                    </p>
                </div>
                <img
                    src="https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1581632104/621512_K9GSN_8358_001_072_0000_Light-Bolso-de-mano-Dionysus-con-GG.jpg">

            </div>
            
        </div>
        
    </div>
    <div class="background">
        <h1>Sản phẩm nổi bật</h1>
        <div class="container d-flex">
            <div class="item">
                <img src="https://product.hstatic.net/1000260559/product/tui_xach_nu_da_mem_handmade__2__542481771ea1419e85439488bdd9da76_master.jpg" alt="không có ảnh">
                <p>Túi xách Chanel Gabrielle màu đen với thiết kế đơn giản đẹp. Màu đen mang đến cho các bạn nữ sự tự tin thoải mái khi sử dụng sản phẩm. Tên viết tắt sản phẩm: Chanel Gabrielle. Nhãn hiệu: Chanel. Sản phẩm được bán tại MiliStore với tên Túi xách Chanel Gabrielle màu đen với thiết kế đơn giản đẹp</p>
                <a href="user/product.htm">Buy now!</a>
            </div>
            <div class="item">
                <img src="https://www.etime.vn/upload/2016-09-10/6008-51.jpg" alt="không có ảnh">
                <p>Túi dạng dây đeo mạ vàng sang trọng và quý phái. - Túi xách nhỏ gọn, chất liệu da chống xước. - Màu sắc đa dạng dễ phối hợp với trang phục. - Bên trong túi rộng có nhiều ngăn tiện lợi để các vật dụng cần thiết. - Phom túi vuông vắn, bề mặt da đẹp mịn mang lại sự sang trọng, bền đẹp.</p>
                <a href="user/product.htm">Buy now!</a>
            </div>
            <div class="item">
                <img src="https://cdn-img-v2.webbnc.net/uploadv2/web/62/6245/product/2018/03/30/05/47/1522388254_z945141110310_de10f4404a6aa7eb28482e2990fc08ed.jpg" alt="không có ảnh">
                <p>Sự kết hợp hòa hảo giữa chất liệu da Monogram và da bê min màng, màu sắc đối lập. tạo nên nét phá cách sống động đầy cá tính. Vô cùng nổi bật và sành điệu mẫu Túi Xách Louis Vuitton Saintonge sẽ không làm bạn thất vọng, khi  kết hợp cùng những bộ trang phục hiện đại và cá tính.</p>
                <a href="user/product.htm">Buy now!</a>
            </div>
            <i class="left-i fas fa-chevron-left"></i>
            <i class="right-i fas fa-chevron-right"></i>
        </div>
    </div>
    <div class="content">
        <div class="container">
            <div class="customer d-flex">
                <ul>
                    <h1>Hỗ trợ khách hàng</h1>
                    <li><i class="fa fa-hand-point-right"></i><a href="">Chính sách bảo hành</a></li>
                    <li><i class="fa fa-hand-point-right"></i><a href="">Chính sách đổi trả</a></li>
                    <li><i class="fa fa-hand-point-right"></i><a href="">Phương thức thanh toán</a></li>
                    <li><i class="fa fa-hand-point-right"></i><a href="">Hướng dẫn đặt hàng</a></li>
                </ul>
                <ul>
                    <h1>Thông tin liên hệ</h1>
                    <li>Địa chỉ: 12 Nguyễn Trãi, phường 8, quận 3, tp Hồ Chí Minh</li>
                    <li>Số điện thoại: +(84)979797979</li>
                    <li>Thời gian làm việc: từ 9:00 đến 22:00</li>
                    <li>Website: sablanca.com</li>
                    <li>Email: sablanca@gmail.com</li>
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