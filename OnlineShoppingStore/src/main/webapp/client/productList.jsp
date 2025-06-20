<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ShopStyle - Product List</title>

<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- Google Fonts (Optional) -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/client/style/styles.css">
</head>
<body class="bg-[#C7A07A] font-roboto text-gray-900">

	<!-- Back Button -->
	<div class="container mx-auto p-6 mb-6">
		<a href="javascript:history.back()"
			class="bg-[#391E10] hover:bg-[#734128] text-white py-2 px-4 rounded-lg transition-colors duration-300">
			&larr; Back to Previous Page </a>
	</div>

	<main class="container mx-auto p-6">
		<h2 class="text-3xl font-semibold text-center text-[#391E10] mb-10">Browse
			Our Collection</h2>

		<!-- Product Grid -->
		<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
			<!-- Loop through products -->
			<c:forEach items="${products}" var="product">
				<div
					class="rounded-lg p-6 transition-all ease-in-out transform hover:scale-105 fade-in gradient-card">

					<!-- Product Image -->
					<img src="${pageContext.request.contextPath}/${product.imageUrl}"
						alt="${product.productName}"
						class="w-full h-56 object-cover rounded-lg mb-6">

					<!-- Product Details -->
					<h3 class="text-xl font-semibold text-black mb-2">${product.productName}</h3>
					<p class="text-xl font-bold text-red-600  mb-4">Rs.
						${product.price}</p>

					<!-- View Details Button -->
					<a
						href="${pageContext.request.contextPath}/user/product-details?productId=${product.productId}"
						class="block text-center text-white py-2 px-4 rounded-lg transition-colors duration-300 btn-theme">
						Buy Now </a>

				</div>
			</c:forEach>
		</div>

		<!-- Empty State -->
		<c:if test="${empty products}">
			<div class="text-center text-gray-500 mt-10 text-lg">
				<p>No products available right now. Check back later!</p>
			</div>
		</c:if>
	</main>

	<!-- Optional JavaScript (for animation interaction) -->
	<script>
        document.querySelectorAll('.scale-up').forEach(card => {
            card.addEventListener('mouseover', () => {
                card.classList.add('transform', 'scale-105');
            });
            card.addEventListener('mouseleave', () => {
                card.classList.remove('transform', 'scale-105');
            });
        });
    </script>
</body>
</html>
