<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Seller" %>
<%@ page import="java.util.List" %>
<%@ include file="./partials/adminHeader.jsp"%>

<%
    List<Seller> sellers = (List<Seller>) request.getAttribute("sellers");
    String mode = (String) request.getAttribute("mode");
    Seller currentSeller = (Seller) request.getAttribute("currentSeller");
%>

<main class="p-6 w-full">
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="bg-green-500 text-white px-4 py-3 rounded-lg shadow mb-6 transition-opacity duration-500 animate-fade-in">
            <p>${success}</p>
            <c:remove var="success" scope="session"/>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="bg-red-500 text-white px-4 py-3 rounded-lg shadow mb-6 transition-opacity duration-500 animate-fade-in">
            <p>${error}</p>
            <c:remove var="error" scope="session"/>
        </div>
    </c:if>

    <!-- Seller Form -->
    <c:if test="${mode == 'edit' || mode == 'create'}">
        <div class="bg-[#FDFCE8] rounded-xl shadow-lg p-6 mb-6 transition-transform transform hover:scale-105 max-w-3xl mx-auto">
            <h2 class="text-2xl font-bold mb-4 text-black">
                <c:choose>
                    <c:when test="${mode == 'create'}">Create New Seller</c:when>
                    <c:otherwise>Edit Seller</c:otherwise>
                </c:choose>
            </h2>
            <form action="${pageContext.request.contextPath}/sellers" method="post" class="space-y-4">
                <input type="hidden" name="action" value="${mode == 'create' ? 'create' : 'update'}">
                <c:if test="${mode == 'edit'}">
                    <input type="hidden" name="id" value="${currentSeller.id}" />
                </c:if>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="text" name="name" value="${currentSeller.name}" placeholder="Name" class="w-full px-4 py-2 rounded-lg bg-white text-black border border-gray-600 focus:outline-none" required />
                    <input type="email" name="email" value="${currentSeller.email}" placeholder="Email" class="w-full px-4 py-2 rounded-lg bg-white text-black border border-gray-600 focus:outline-none" required />
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="password" name="password" placeholder="Password" class="w-full px-4 py-2 rounded-lg bg-white text-black border border-gray-600 focus:outline-none" <c:if test="${mode == 'create'}">required</c:if> />
                    <input type="text" name="storeName" value="${currentSeller.storeName}" placeholder="Store Name" class="w-full px-4 py-2 rounded-lg bg-white text-black border border-gray-600 focus:outline-none" required />
                </div>

                <label class="inline-flex items-center">
                    <input type="checkbox" name="approved" class="form-checkbox h-5 w-5 text-purple-600" id="approved" ${currentSeller.approved ? 'checked' : ''}>
                    <span class="ml-2 text-white">Approved</span>
                </label>

                <div class="flex justify-end space-x-3">
                    <a href="${pageContext.request.contextPath}/sellers" class="bg-gray-600 hover:bg-gray-500 text-white px-4 py-2 rounded">Cancel</a>
                    <button type="submit" class="bg-[#C7A07A] hover:bg-[#C7A07A] text-black px-4 py-2 rounded">
                        <c:choose>
                            <c:when test="${mode == 'create'}">Create Seller</c:when>
                            <c:otherwise>Update Seller</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </c:if>

    <!-- Seller View Details -->
    <c:if test="${mode == 'view'}">
        <div class="bg-gray-900 rounded-xl shadow-lg p-6 mb-6 max-w-3xl mx-auto text-white">
            <h2 class="text-2xl font-bold mb-4 text-purple-400">Seller Details</h2>
            <div class="space-y-3">
                <p><strong>Name:</strong> ${currentSeller.name}</p>
                <p><strong>Email:</strong> ${currentSeller.email}</p>
                <p><strong>Store:</strong> ${currentSeller.storeName}</p>
                <p><strong>Approved:</strong> 
                    <span class="${currentSeller.approved ? 'text-green-400' : 'text-yellow-400'}">
                        ${currentSeller.approved ? 'Yes' : 'No'}
                    </span>
                </p>
            </div>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/sellers" class="text-purple-400 hover:underline">← Back to List</a>
            </div>
        </div>
    </c:if>

    <!-- Seller List Table -->
    <c:if test="${mode == 'list'}">
        <div class="bg-[#FDFCE8] rounded-xl shadow-lg overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-700 flex justify-between items-center">
                <h2 class="text-2xl font-bold text-black">Sellers</h2>
                <a href="${pageContext.request.contextPath}/sellers?mode=create" class="bg-[#734128] hover:bg-[#734128] text-white px-4 py-2 rounded-md text-sm font-medium">
                    + Add Seller
                </a>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-700 text-black">
                    <thead class="bg-[#FDFCE8]">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">ID</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Email</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Store</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Approved</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-[#FDFCE8] divide-y divide-gray-800">
                        <c:forEach var="s" items="${sellers}">
                            <tr class="hover:bg-[#C7A07A] transition-all">
                                <td class="px-6 py-4 whitespace-nowrap">${s.id}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${s.name}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${s.email}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${s.storeName}</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="text-sm ${s.approved ? 'text-green-400' : 'text-yellow-400'}">
                                        ${s.approved ? 'Yes' : 'No'}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="${pageContext.request.contextPath}/sellers?mode=view&id=${s.id}" class="text-blue-400 hover:underline mr-3">View</a>
                                    <a href="${pageContext.request.contextPath}/sellers?mode=edit&id=${s.id}" class="text-yellow-400 hover:underline mr-3">Edit</a>
                                    <c:if test="${!s.approved}">
                                        <a href="${pageContext.request.contextPath}/sellers?action=approve&id=${s.id}" class="text-green-400 hover:underline mr-3">Approve</a>
                                    </c:if>
                                    <form action="${pageContext.request.contextPath}/sellers" method="post" class="inline">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="id" value="${s.id}" />
                                        <button type="submit" onclick="return confirm('Are you sure?')" class="text-red-400 hover:underline">Delete</button>
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

<%@ include file="./partials/adminFooter.jsp"%>

<style>
    .animate-fade-in {
        animation: fadeIn 0.7s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>
