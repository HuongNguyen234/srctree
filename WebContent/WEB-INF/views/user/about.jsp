<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Sablanca | Thông tin cửa hàng</title>
	<base href="${pageContext.servletContext.contextPath}/">
	<style><%@include file="/WEB-INF/css/about.css"%></style>
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
	                        	<li><a href="user/show_prod.htm?code=${t.id}">${t.name}</a></li>
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
    <div class="content">

        <div class="container">
            <div class="item d-flex">
                <div class="text">
                    <h1>Giới thiệu chung về cửa hàng</h1>
                    <p>Ngành thời trang có ảnh hưởng rất lớn đến cuộc sống thời hiện đại và gần như quyết định phong
                        cách sống, cái đẹp của con người ngày nay. Mua sắm quần áo, đồ thời trang trở thành việc không
                        thể thiếu của bất cứ ai, nhằm thay đổi hình ảnh bản thân và xây dựng hình ảnh cá nhân. Vì nó có
                        ảnh hưởng lớn đến vậy, khách hàng chỉ tin vào nhưng thương hiệu với sản phẩm chất lượng, đẹp,
                        sang trọng. Để khách hàng luôn tin tưởng và đến với mình cũng như khẳng định một hình ảnh đầy
                        thời trang, đẳng cấp, các doanh nghiệp trong ngành luôn cố gắng đầu tư, xây dựng lớp áo thương
                        hiệu thật ấn tượng. Xu thế đó là càng nổi bật, càng sang trọng càng tốt.</p>
                </div>
                <img src="image/shop1.jpg" alt="">
            </div>
            <div class="agency d-flex">
                <ul>
                    <h1>Các cơ sở chính</h1>
                    <li class="d-flex">
                        <i class="fa fa-hand-point-right"></i>
                        <p>12 Nguyễn Trãi, phường 8, quận 3, tp Hồ Chí Minh</p>
                    </li>
                    <li class="d-flex">
                        <i class="fa fa-hand-point-right"></i>
                        <p>12 Nguyễn Trãi, phường 8, quận 3, tp Hồ Chí Minh</p>
                    </li>
                    <li class="d-flex">
                        <i class="fa fa-hand-point-right"></i>
                        <p>12 Nguyễn Trãi, phường 8, quận 3, tp Hồ Chí Minh</p>
                    </li>
                </ul>
                <img src="image/shop2.png" alt="">
            </div>
			<div class="bh d-flex">
			<h2 style="color: #00adff">Lỗi do nhà sản xuất:</h2>
                <table>
               		<tr>
               			<th>Tháng thứ nhất</th>
               			<th>Tháng thứ 2 trở đi</th>
               		</tr>
               		<tr>
               			<td>
               				<ul>
               					<li>-1 đổi 1 (cùng mẫu, cùng màu, cùng giá...).</li>
               					<li>-Trường hợp sản phẩm đổi hết hàng, khách hàng có thể đổi sang sản phẩm khác cùng nhóm hàng có giá trị lớn hơn 50% giá trị sản phẩm lỗi.</li>
               				</ul>
               			</td>
               			<td>
               				<ul>
               					<li>-Gửi túi bảo hành theo quy định của shop.</li>
               					<li>-Khách hàng trả túi & SHOP hoàn lại tiền và thu phí thêm 5% so với mức hoàn tiền khi trả ở tháng thứ 1.</li>
               				</ul>
               			</td>
               		</tr>
                </table>
            </div>
            <div class="bh d-flex">
			<h2 style="color: #00adff">Sản phẩm không lỗi:</h2>
                <table>
               		<tr>
               			<th>Tháng thứ nhất</th>
               			<th>Tháng thứ 2 trở đi</th>
               		</tr>
               		<tr>
               			<td>
               				<ul>
               					<li>-Hoàn lại tiền túi với giá bằng 80% giá trên hoá đơn.</li>
               				</ul>
               			</td>
               			<td>
               				<ul>
               					<li>-Hoàn lại tiền với mức phí thêm 5% so với tháng thứ 1 (80%). VD: tháng thứ 2 hoàn lại tiền với mức giá 75% giá trên hoá đơn, tháng thứ 3 là 70%...</li>
               				</ul>
               			</td>
               		</tr>
                </table>
            </div>
            <div class="bh d-flex" style="text-align: left">
			<h2 style="color: #00adff">Sản phẩm lỗi do người sử dụng:</h2>
                <table>
               		<tr>
               			<td>Không đủ điều kiện bảo hành theo qui định của SHOP.</td>
               		</tr>
               		<tr>
               			<td>Túi không giữ nguyên 100% hình dạng ban đầu.</td>
               		</tr>
               		<tr>
               			<td>Túi bị trầy xước.</td>
               		</tr>
               		<tr>
               			<th>=> Không áp dụng bảo hành, đổi trả. SHOP hỗ trợ bảo hành, khách hàng chịu chi phí sửa chữa.</th>
               		</tr>
                </table>
            </div>
             <div class="tt d-flex" style="text-align: left; margin-top: 20px">
			<h2 style="color: #00adff">Hướng dẫn thanh toán:</h2>
                <ul style="line-height: 30px">
                	<li>-Đầu tiên các bạn chọn vào All products, ở đây có các sản phẩm mà bạn muốn mua!</li>
                	
                	<li>-Sau đó bên dưới mỗi sản phẩm có nut Mua ngay, các bạn ấn vào nút sẽ có hiển thị sản phẩm, bạn chọn vào số lượng mà mình muốn mua và ấn thêm vào giỏ hàng.</li>
                	
                	<li>-Vậy là bạn đã đặt hàng xong, vui lòng chờ quản trị viên xác nhận bằng mail của bạn!</li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="content1">
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
                    <li>Số điện thoại: +8479797979</li>
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