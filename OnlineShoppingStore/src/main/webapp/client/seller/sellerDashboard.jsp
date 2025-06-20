<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../partials/SellerHeader.jsp"%>

<main class="flex-1 p-8 bg-[#E2CEB1] min-h-screen">
	<div
		class="max-w-full bg-[#5C3B28] p-6 rounded-lg shadow-lg transition transform hover:scale-[1.01]">
		<h2
			class="text-3xl font-semibold mb-6 text-white border-b border-[#8B5E3C] pb-2">
			Welcome to Your Seller Dashboard</h2>

		<!-- Seller Overview -->
		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
			<div class="bg-white p-4 rounded-lg shadow-lg">
				<h3 class="text-xl font-semibold text-[#5C3B28]">Total Products</h3>
				<p class="text-2xl font-bold mt-2 text-[#5C3B28]">45</p>
			</div>
			<div class="bg-white p-4 rounded-lg shadow-lg">
				<h3 class="text-xl font-semibold text-[#5C3B28]">Pending Orders</h3>
				<p class="text-2xl font-bold mt-2 text-[#5C3B28]">12</p>
			</div>
			<div class="bg-white p-4 rounded-lg shadow-lg">
				<h3 class="text-xl font-semibold text-[#5C3B28]">Total Sales</h3>
				<p class="text-2xl font-bold mt-2 text-[#5C3B28]">Rs. 584,400.00</p>
			</div>
		</div>

		<!-- Quick Actions -->
		<div class="mt-8">
			<h3 class="text-2xl font-semibold text-white mb-4">Quick Actions</h3>
			<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
				<a href="${pageContext.request.contextPath}/seller/products"
					class="block bg-[#8B5E3C] hover:bg-[#A76F4D] text-white text-center py-4 rounded-lg shadow-md transition-all">
					Add New Product </a> <a href="#"
					class="block bg-[#8B5E3C] hover:bg-[#A76F4D] text-white text-center py-4 rounded-lg shadow-md transition-all">
					View Orders </a>
			</div>
		</div>
	</div>
</main>

<%@ include file="../partials/SellerFooter.jsp"%>
