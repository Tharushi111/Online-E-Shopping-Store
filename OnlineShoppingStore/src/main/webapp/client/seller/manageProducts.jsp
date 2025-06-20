<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../partials/SellerHeader.jsp"%>

<main class="p-6 w-full">
	<!-- Success/Error Messages -->
	<c:if test="${not empty success}">
		<div
			class="bg-green-100 text-green-800 px-4 py-3 rounded-lg shadow mb-6 animate-fade-in">
			<p>${success}</p>
			<c:remove var="success" scope="session" />
		</div>
	</c:if>
	<c:if test="${not empty error}">
		<div
			class="bg-red-100 text-red-800 px-4 py-3 rounded-lg shadow mb-6 animate-fade-in">
			<p>${error}</p>
			<c:remove var="error" scope="session" />
		</div>
	</c:if>

	<!-- Product Form -->
	<c:if test="${mode == 'create' || mode == 'edit'}">
		<div
			class="bg-[#FDFCE8] rounded-xl shadow-lg p-6 mb-6 max-w-3xl mx-auto transition-transform transform hover:scale-105">
			<h2 class="text-2xl font-bold mb-4 text-black">
				<c:choose>
					<c:when test="${mode == 'create'}">Add New Product</c:when>
					<c:otherwise>Edit Product</c:otherwise>
				</c:choose>
			</h2>
			<form action="${pageContext.request.contextPath}/seller/products"
				method="post" enctype="multipart/form-data" class="space-y-4"
				id="productForm">
				<input type="hidden" name="action"
					value="${mode == 'create' ? 'create' : 'update'}" />
				<c:if test="${mode == 'edit'}">
					<input type="hidden" name="id" value="${currentProduct.productId}" />
					<input type="hidden" name="existingImageUrl"
						value="${currentProduct.imageUrl}" />
				</c:if>

				<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
					<input type="text" name="productName"
						value="${currentProduct.productName}" placeholder="Product Name"
						class="w-full px-4 py-2 rounded-lg bg-white text-black border border-gray-600"
						 /> <input type="number" name="price" step="0.01"
						min="0.01" value="${currentProduct.price}" placeholder="Price"
						class="w-full px-4 py-2 rounded-lg bg-white text-black border border-gray-600"
						 />
				</div>

				<textarea name="description" placeholder="Description" rows="4"
					class="w-full px-4 py-2 rounded-lg bg-white text-black border border-gray-600 resize-none"
					>${currentProduct.description}</textarea>

				<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
					<input type="number" name="quantity" min="0"
						value="${currentProduct.quantity}" placeholder="Stock Quantity"
						class="w-full px-4 py-2 rounded-lg bg-white text-black border border-gray-600"
						 /> <input type="file" name="image" accept="image/*"
						class="w-full text-black" />
				</div>

				<c:if test="${mode == 'edit' && not empty currentProduct.imageUrl}">
					<div class="mt-2 text-black text-sm">
						<p>Current Image:</p>
						<img
							src="${pageContext.request.contextPath}/${currentProduct.imageUrl}"
							alt="Product Image"
							class="rounded max-h-32 border border-gray-700 mt-1">
					</div>
				</c:if>

				<div class="flex justify-end space-x-3">
					<a href="${pageContext.request.contextPath}/seller/products"
						class="bg-gray-600 hover:bg-gray-500 text-white px-4 py-2 rounded">Cancel</a>
					<button type="submit"
						class="bg-[#734128] hover:bg-[#C7A07A] text-white px-4 py-2 rounded">
						<c:choose>
							<c:when test="${mode == 'create'}">Create Product</c:when>
							<c:otherwise>Update Product</c:otherwise>
						</c:choose>
					</button>
				</div>
			</form>
		</div>
	</c:if>

	<!-- Product Details -->
	<c:if test="${mode == 'view'}">
		<div
			class="bg-[#FDFCE8] rounded-xl shadow-lg p-6 mb-6 max-w-3xl mx-auto text-black">
			<h2 class="text-2xl font-bold mb-4 text-[#734128]">Product
				Details</h2>
			<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
				<div>
					<p>
						<strong>Name:</strong> ${currentProduct.productName}
					</p>
					<p>
						<strong>Price:</strong> Rs. ${currentProduct.price}
					</p>
					<p>
						<strong>Stock:</strong> ${currentProduct.quantity}
					</p>
					<p>
						<strong>Description:</strong> ${currentProduct.description}
					</p>
				</div>
				<div>
					<c:if test="${not empty currentProduct.imageUrl}">
						<img
							src="${pageContext.request.contextPath}/${currentProduct.imageUrl}"
							alt="Product Image"
							class="rounded-lg max-h-64 object-cover border border-gray-700">
					</c:if>
					<c:if test="${empty currentProduct.imageUrl}">
						<p class="text-gray-400">No image available</p>
					</c:if>
				</div>
			</div>
			<div class="mt-4">
				<a href="${pageContext.request.contextPath}/seller/products"
					class="text-[#734128] hover:underline">← Back to List</a>
			</div>
		</div>
	</c:if>

	<!-- Product List -->
	<c:if test="${mode == 'list'}">
		<div class="bg-[#FDFCE8] rounded-xl shadow-lg overflow-hidden">
			<div
				class="px-6 py-4 border-b border-gray-300 flex justify-between items-center">
				<h2 class="text-2xl font-bold text-black">Your Products</h2>
				<a
					href="${pageContext.request.contextPath}/seller/products?mode=create"
					class="bg-[#734128] hover:bg-[#C7A07A] text-white px-4 py-2 rounded-md text-sm font-medium">
					+ Add Product </a>
			</div>
			<div class="overflow-x-auto">
				<table class="min-w-full divide-y divide-gray-300 text-black">
					<thead class="bg-[#FDFCE8]">
						<tr>
							<th
								class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">ID</th>
							<th
								class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Name</th>
							<th
								class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Price</th>
							<th
								class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Stock</th>
							<th
								class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Actions</th>
						</tr>
					</thead>
					<tbody class="bg-white divide-y divide-gray-200">
						<c:forEach var="p" items="${products}">
							<tr class="hover:bg-[#C6A691] transition-all">
								<td class="px-6 py-4 whitespace-nowrap">${p.productId}</td>
								<td class="px-6 py-4 whitespace-nowrap">${p.productName}</td>
								<td class="px-6 py-4 whitespace-nowrap">Rs. ${p.price}</td>
								<td class="px-6 py-4 whitespace-nowrap">${p.quantity}</td>
								<td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
									<a
									href="${pageContext.request.contextPath}/seller/products?mode=view&id=${p.productId}"
									class="text-blue-600 hover:underline mr-3">View</a> <a
									href="${pageContext.request.contextPath}/seller/products?mode=edit&id=${p.productId}"
									class="text-green-600 hover:underline mr-3">Edit</a>
									<form
										action="${pageContext.request.contextPath}/seller/products"
										method="post" class="inline">
										<input type="hidden" name="action" value="delete" /> <input
											type="hidden" name="id" value="${p.productId}" />
										<button type="submit"
											onclick="return confirm('Are you sure you want to delete this product?')"
											class="text-red-600 hover:underline">Delete</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</c:if>
</main>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("productForm");

    if (form) {
      form.addEventListener("submit", function (e) {
        const name = form.productName.value.trim();
        const price = parseFloat(form.price.value);
        const quantity = parseInt(form.quantity.value);

        if (name === "") {
          alert("Product name is required.");
          form.productName.focus();
          e.preventDefault();
          return;
        }

        if (isNaN(price) || price <= 0) {
          alert("Please enter a valid price greater than 0.");
          form.price.focus();
          e.preventDefault();
          return;
        }

        if (isNaN(quantity) || quantity < 0 || !Number.isInteger(quantity)) {
          alert("Please enter a valid stock quantity (non-negative integer).");
          form.quantity.focus();
          e.preventDefault();
        }
      });
    }
  });
</script>

<%@ include file="../partials/SellerFooter.jsp"%>