<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Seller" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("seller") == null) {
        response.sendRedirect(request.getContextPath() + "/seller/login");
        return;
    }
    Seller seller = (Seller) session.getAttribute("seller");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#E2CEB1] from-purple-900 via-indigo-900 to-light-brown-900 min-h-screen text-white flex font-sans">

    <!-- Sidebar -->
    <aside id="sidebar" class="w-64 bg-[#391E10] p-6 min-h-screen shadow-lg transition-all duration-300 ease-in-out">
        
        <h2 class="text-2xl font-bold mb-8 text-white"><a href="${pageContext.request.contextPath}/index" class="block px-4 py-2 rounded hover:bg-[#A76F4D] transition" >ShopStyle</a></h2>
        <nav class="space-y-4">
            <a href="${pageContext.request.contextPath}/client/seller/sellerDashboard.jsp" class="block px-4 py-2 rounded hover:bg-[#8B5E3C] transition">Dashboard</a>
            <a href="${pageContext.request.contextPath}/seller/products" class="block px-4 py-2 rounded hover:bg-[#8B5E3C] transition">Manage Products</a>
            <a href="#" class="block px-4 py-2 rounded hover:bg-[#8B5E3C] transition">Orders</a>
            <a href="${pageContext.request.contextPath}/seller/profile" class="block px-4 py-2 rounded hover:bg-[#8B5E3C] transition">Profile</a>
            <a href="${pageContext.request.contextPath}/seller/logout" class="block px-4 py-2 text-red-700 hover:text-red-500 ">Logout</a>
        </nav>
    </aside>


</body>
</html>
