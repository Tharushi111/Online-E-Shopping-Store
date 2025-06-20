<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../partials/SellerHeader.jsp"%>

<main class="p-6 w-full bg-[#F3E5AB] min-h-screen text-[#3C2F2F]">
	<!-- Success/Error Messages -->
	<c:if test="${not empty success}">
		<div
			class="bg-green-700 text-white px-4 py-3 rounded-lg shadow mb-6 animate-fade-in">
			<p>${success}</p>
			<c:remove var="success" scope="session" />
		</div>
	</c:if>
	<c:if test="${not empty error}">
		<div
			class="bg-red-500 text-white px-4 py-3 rounded-lg shadow mb-6 animate-fade-in">
			<p>${error}</p>
			<c:remove var="error" scope="session" />
		</div>
	</c:if>

	<!-- Seller Profile Form -->
	<div
		class="bg-[#8B5E3C] rounded-xl shadow-lg p-6 mb-6 max-w-3xl mx-auto text-white">
		<h2 class="text-2xl font-bold mb-4 border-b border-[#5C4033] pb-2">My
			Profile</h2>

		<form action="${pageContext.request.contextPath}/seller/profile"
			method="post" class="space-y-4">
			<input type="hidden" name="action" value="update">

			<!-- Name and Email -->
			<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
				<input type="text" name="name" value="${seller.name}"
					placeholder="Full Name"
					class="w-full px-4 py-2 rounded-lg bg-white text-black  border border-[#5C4033] focus:outline-none"
					required /> <input type="email" name="email"
					value="${seller.email}" placeholder="Email"
					class="w-full px-4 py-2 rounded-lg  text-black border border-[#5C4033] focus:outline-none"
					required />
			</div>

			<!-- Store Name -->
			<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
				<input type="text" name="storeName" value="${seller.storeName}"
					placeholder="Store Name"
					class="w-full px-4 py-2 rounded-lg text-black border border-[#5C4033] focus:outline-none"
					required />
			</div>

			<!-- Password (Optional) -->
			<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
				<input type="password" name="password"
					placeholder="New Password (leave blank if not changing)"
					class="w-full px-4 py-2 rounded-lg text-black border border-[#5C4033] focus:outline-none" />
			</div>


			<div class="flex justify-end space-x-3 pt-4">
				<a href="${pageContext.request.contextPath}/seller/products"
					class="bg-red-800 hover:bg-red-600 text-white px-4 py-2 rounded">Cancel</a>
				<button type="submit"
					class="bg-blue-800 hover:bg-blue-600 text-white px-4 py-2 rounded">Update
					Profile</button>
			</div>
		</form>

	</div>
</main>

<%@ include file="../partials/SellerFooter.jsp"%>

<style>
.animate-fade-in {
	animation: fadeIn 0.7s ease-in-out;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
