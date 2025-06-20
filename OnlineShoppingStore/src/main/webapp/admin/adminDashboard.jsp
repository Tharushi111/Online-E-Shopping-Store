<%@ include file="./partials/adminHeader.jsp"%>


    <!-- Main Content -->
    <main class="flex-1 p-6">
        <header class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-black">Welcome, <%= adminName %> !</h1>
            <button class="md:hidden bg-gray-700 p-2 rounded text-sm">☰</button>
        </header>

        <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="bg-[#FDFCE8] p-6 rounded-xl shadow hover:shadow-xl transition">
                <h3 class="text-lg font-semibold text-black mb-2">Total Users</h3>
                <p class="text-3xl font-bold text-black">1245</p>
            </div>
            <div class="bg-[#FDFCE8] p-6 rounded-xl shadow hover:shadow-xl transition">
                <h3 class="text-lg font-semibold text-black mb-2">Pending Products</h3>
                <p class="text-3xl font-bold text-black">34</p>
            </div>
            <div class="bg-[#FDFCE8] p-6 rounded-xl shadow hover:shadow-xl transition">
                <h3 class="text-lg font-semibold text-black mb-2">Monthly Sales</h3>
                <p class="text-3xl font-bold text-black">$8,420</p>
            </div>
        </section>



    <!-- Best Selling Products Table -->
    <section class="mt-10">
        <h2 class="text-2xl font-bold text-black mb-4">Best Selling Products</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-[#FDFCE8] text-black rounded-lg overflow-hidden">
                <thead class="bg-[#FDFCE8] text-left text-sm uppercase">
                    <tr>
                        <th class="px-6 py-3">Product Image</th>
                        <th class="px-6 py-3">Product Name</th>
                        <th class="px-6 py-3">Quantity Sold</th>
                        <th class="px-6 py-3">Price</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="border-t border-gray-600 hover:bg-[#C7A07A] transition">
                        <td class="px-6 py-4">
                            <img src="${pageContext.request.contextPath}/admin/images/pants.jpeg.jpg" alt="Product 1" class="w-12 h-12 object-cover rounded">
                        </td>
                        <td class="px-6 py-4">Cargo Pants</td>
                        <td class="px-6 py-4">320</td>
                        <td class="px-6 py-4">$250.99</td>
                    </tr>
                    <tr class="border-t border-gray-600 hover:bg-[#C7A07A] transition">
                        <td class="px-6 py-4">
                           <img src="${pageContext.request.contextPath}/admin/images/shoes.jpeg.jpg" alt="Product 2" class="w-12 h-12 object-cover rounded">
                        </td>
                        <td class="px-6 py-4">Nike Shoes</td>
                        <td class="px-6 py-4">295</td>
                        <td class="px-6 py-4">$159.99</td>
                    </tr>
                    <tr class="border-t border-gray-600 hover:bg-[#C7A07A] transition">
                        <td class="px-6 py-4">
                            <img src="${pageContext.request.contextPath}/admin/images/hoodie.jpeg.jpg" alt="Product 3" class="w-12 h-12 object-cover rounded">
                        </td>
                        <td class="px-6 py-4">Mens Hoodie</td>
                        <td class="px-6 py-4">210</td>
                        <td class="px-6 py-4">$320.00</td>
                    </tr>
                    <tr class="border-t border-gray-600 hover:bg-[#C7A07A] transition">
                        <td class="px-6 py-4">
                            <img src="${pageContext.request.contextPath}/admin/images/t-shirt.jpeg.jpg" alt="Product 4" class="w-12 h-12 object-cover rounded">
                        </td>
                        <td class="px-6 py-4">Mens T-shirt</td>
                        <td class="px-6 py-4">180</td>
                        <td class="px-6 py-4">$339.50</td>
                    </tr>
                    <tr class="border-t border-gray-600 hover:bg-[#C7A07A] transition">
                        <td class="px-6 py-4">
                            <img src="${pageContext.request.contextPath}/admin/images/watch.jpeg.jpg" alt="Product 5" class="w-12 h-12 object-cover rounded">
                        </td>
                        <td class="px-6 py-4">Mens Gold Watch</td>
                        <td class="px-6 py-4">165</td>
                        <td class="px-6 py-4">$1170.00</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>
</main>

<%@ include file="./partials/adminFooter.jsp"%>
