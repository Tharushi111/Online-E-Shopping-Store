<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
Object user = session.getAttribute("user");
Object admin = session.getAttribute("admin");
Object seller = session.getAttribute("seller");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ShopStyle - Modern Shopping Experience</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/client/style/styles.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

</head>
<body class="page-bg">
	<!-- Header -->
	<header class="header">
		<div class="logo">ShopStyle</div>
		<nav class="nav-menu">
			<ul>
				<li><a href="${pageContext.request.contextPath}/index">Home</a></li>
				<li><a href="${pageContext.request.contextPath}//user/products">Products</a></li>
				<li><a href="#about">About Us</a></li>
				<li><a href="#contact">Contact</a></li>
			</ul>
		</nav>
		<div class="auth-buttons">


			<%
			if (user != null) {
			%>
			<button class="dashboard"
				onclick="window.location.href = '<%=request.getContextPath()%>/client/user/userDashboard.jsp';">
				User Dashboard</button>
			<button class="logout"
				onclick="window.location.href = '<%=request.getContextPath()%>/user/logout';">
				Logout</button>
			<%
			} else if (seller != null) {
			%>
			<button class="dashboard"
				onclick="window.location.href = '<%=request.getContextPath()%>/client/seller/sellerDashboard.jsp';">
				Seller Dashboard</button>
			<button class="logout"
				onclick="window.location.href = '<%=request.getContextPath()%>/seller/logout';">
				Logout</button>
			<%
			} else if (admin != null) {
			%>
			<button class="dashboard"
				onclick="window.location.href = '<%=request.getContextPath()%>/admin';">
				Admin Dashboard</button>
			<button class="logout"
				onclick="window.location.href = '<%=request.getContextPath()%>/admin/logout';">
				Logout</button>
			<%
			} else {
			%>
			<button class="sign-in"
				onclick="window.location.href = '<%=request.getContextPath()%>/seller/login';">
				Seller Sign In</button>
			<button class="sign-up"
				onclick="window.location.href = '<%=request.getContextPath()%>/login';">
				User Sign In</button>
			<%
			}
			%>



		</div>
	</header>

	<section class="hero" id="home"
		style="position: relative; height: 100vh; overflow: hidden;">

		<!-- Swiper Slider as background -->
		<div class="swiper heroSwiper"
			style="position: absolute; inset: 0; z-index: 0;">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<img
						src="${pageContext.request.contextPath}/client/images/home.jpg"
						class="w-full h-full object-cover" />
				</div>
				<div class="swiper-slide">
					<img
						src="${pageContext.request.contextPath}/client/images/home2.jpg"
						class="w-full h-full object-cover" />
				</div>
			</div>
		</div>

		<!-- Hero Content -->
		<div class="hero-content"
			style="position: absolute; z-index: 2; color: white; bottom: 40px;">
			<h1>Welcome to ShopStyle</h1>
			<p>Discover the latest trends in fashion and lifestyle</p>
			<button class="shop-now">Shop Now</button>
		</div>

	</section>





	<!-- Home Products -->
	<section class="home-products" id="products">
		<h2>Our Collections</h2>
		<div class="category-grid">
			<div class="category-card">
				<img
					src="https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg"
					alt="Women's Fashion">
				<h3>Women's Fashion</h3>
				<a href="#" class="category-link">Shop Now</a>
			</div>
			<div class="category-card">
				<img
					src="https://images.pexels.com/photos/1049317/pexels-photo-1049317.jpeg"
					alt="Men's Fashion">
				<h3>Men's Fashion</h3>
				<a href="#" class="category-link">Shop Now</a>
			</div>
			<div class="category-card">
				<img
					src="https://images.pexels.com/photos/1620760/pexels-photo-1620760.jpeg"
					alt="Kids' Fashion">
				<h3>Kids' Fashion</h3>
				<a href="#" class="category-link">Shop Now</a>
			</div>
			<div class="category-card">
				<img
					src="https://images.pexels.com/photos/1927259/pexels-photo-1927259.jpeg"
					alt="Accessories">
				<h3>Accessories</h3>
				<a href="#" class="category-link">Shop Now</a>
			</div>
		</div>
	</section>

	<!-- Featured Products -->
	<section class="featured">
		<h2>Featured Products</h2>
		<div class="product-grid">

			<div class="product-card">
				<img
					src="https://images.pexels.com/photos/1464625/pexels-photo-1464625.jpeg"
					alt="Fashion Item">
				<h3>Trendy Collection</h3>
				<p>Starting at Rs. 250.00</p>
			</div>
			<div class="product-card">
				<img
					src="https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg"
					alt="Accessories">
				<h3>Accessories</h3>
				<p>Starting at Rs. 100.00</p>
			</div>
			<div class="product-card">
				<img
					src="https://images.pexels.com/photos/1478442/pexels-photo-1478442.jpeg"
					alt="Footwear">
				<h3>Footwear</h3>
				<p>Starting at Rs. 2000.00</p>
			</div>
		</div>
	</section>

	<!-- About Us -->
	<section class="about" id="about">
		<h2>About Us</h2>
		<div class="about-content">
			<img
				src="https://images.pexels.com/photos/3184287/pexels-photo-3184287.jpeg"
				alt="Our Team">
			<div class="about-text">
				<p>ShopStyle is your premier destination for modern fashion and
					lifestyle products. With over a decade of experience, we bring you
					the latest trends and highest quality items from around the world.</p>
				<p>Our commitment to customer satisfaction and sustainable
					fashion makes us the preferred choice for conscious shoppers.</p>
			</div>
		</div>
	</section>

	<!-- Contact Section -->
	<section class="contact" id="contact">
		<h2>Contact Us</h2>
		<div class="contact-container">
			<div class="contact-info">
				<h3>Get in Touch</h3>
				<p>
					<strong>Address:</strong> 159, 2nd Block, World Trade Center,
					Colombo, Sri Lanka
				</p>
				<p>
					<strong>Phone:</strong> +94-112244689
				</p>
				<p>
					<strong>Email:</strong> info@shopstyle.com
				</p>
				<div class="business-hours">
					<h4>Business Hours</h4>
					<p>Monday - Friday: 9:00 AM - 8:00 PM</p>
					<p>Saturday - Sunday: 10:00 AM - 6:00 PM</p>
				</div>
			</div>
			<form class="contact-form">
				<input type="text" placeholder="Your Name" required> <input
					type="email" placeholder="Your Email" required> <input
					type="text" placeholder="Subject" required>
				<textarea placeholder="Your Message" required></textarea>
				<button type="submit" class="submit-btn">Send Message</button>
			</form>
		</div>
	</section>

	<!-- Promotional Section -->
	<section class="promo">
		<div class="promo-card">
			<h3>Free Shipping</h3>
			<p>On orders over Rs. 5000.00</p>
		</div>
		<div class="promo-card">
			<h3>24/7 Support</h3>
			<p>Always here to help</p>
		</div>
		<div class="promo-card">
			<h3>Easy Returns</h3>
			<p>30-day return policy</p>
		</div>
	</section>

	<!-- Footer -->
	<footer class="footer">
		<div class="footer-content">
			<div class="footer-section">
				<h3>Contact Us</h3>
				<p>Email: info@shopstyle.com</p>
				<p>Phone: +94-112244689</p>
				<p>Address: 159, 2nd Block, World Trade Center, Colombo, Sri
					Lanka</p>
			</div>
			<div class="footer-section">
				<h3>Quick Links</h3>
				<ul>
					<li><a href="#faq">FAQ</a></li>
					<li><a href="#shipping">Shipping Info</a></li>
					<li><a href="#returns">Returns</a></li>
					<li><a href="#privacy">Privacy Policy</a></li>
				</ul>
			</div>
			<div class="footer-section">
				<h3>Newsletter</h3>
				<p>Subscribe for updates and exclusive offers</p>
				<input type="email" placeholder="Enter your email">
				<button>Subscribe</button>
			</div>
		</div>
		<div class="footer-bottom">
			<p>&copy; 2025 ShopStyle. All rights reserved.</p>
		</div>
	</footer>
	<script>
		const heroSwiper = new Swiper(".heroSwiper", {
			loop : true,
			autoplay : {
				delay : 3000,
				disableOnInteraction : false,
			},
			effect : "slide",
		});
	</script>

	<script
		src="${pageContext.request.contextPath}/client/script/script.js"></script>
</body>
</html>