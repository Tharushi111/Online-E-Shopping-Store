<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Product Details</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class=" bg-[#C7A07A] font-roboto text-gray-900">

	<!-- Back Button -->
	<div class="p-6">
		<a href="${pageContext.request.contextPath}/user/products"
			class="bg-[#391E10] hover:bg-[#734128] text-white py-2 px-4 rounded-lg transition-colors duration-300">
			← Back to Products </a>

	</div>

	<main
		class="max-w-7xl mx-auto bg-[#FFFBDE] gradient-card shadow-lg rounded-lg p-8 mt-6">
		<div class="grid grid-cols-1 md:grid-cols-2 p-8 gap-8">
			<!-- Image -->
			<div>
				<img src="${pageContext.request.contextPath}/${product.imageUrl}"
					alt="${product.productName}"
					class="rounded-lg shadow-md w-50 object-cover h-50">
			</div>

			<!-- Details -->
			<div class="text-gray-900">
				<h2 class="text-3xl font-bold mb-4">${product.productName}</h2>
				<p class="mb-2 text-gray-700">${product.description}</p>
				<p class="text-xl font-semibold text-red-600 mb-4">Rs.
					${product.price}</p>
				<p class="text-sm text-gray-600 mb-2">Available Quantity:
					${product.quantity}</p>
				<p class="text-sm text-gray-600 mb-6">
					Status: <span
						class="${product.quantity > 0 ? 'text-green-600' : 'text-red-600'}">
						${product.quantity > 0 ? 'In Stock' : 'Out of Stock'} </span>
				</p>
				<p class="text-sm text-gray-600 mb-6">
					Quantity : <input type="number" max="${product.quantity}" min="1"
						name="quantity" value="1" placeholder="Stock Quantity"
						class="w-20 px-4 py-2 rounded-lg bg-[#C7A07A] text-white border border-white-600 focus:outline-none"
						required />

				</p>

				<button
					class="bg-yellow-900 text-white px-6 py-2 rounded hover:bg-yellow-800 transition">
					Proceed to Checkout</button><br><br><br>
				<a href="${pageContext.request.contextPath}/user/reviews"
   					class="bg-yellow-500 text-white px-6 py-2 rounded hover:bg-yellow-600 transition inline-block">
   					Reviews - ★★★★★(112)
				</a>

			</div>
		</div>
	</main>
</body>
</html>