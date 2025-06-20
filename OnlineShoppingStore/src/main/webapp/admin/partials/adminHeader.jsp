<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    String adminName = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#E2CEB1] to-black min-h-screen text-white">
    <div class="flex min-h-screen"> <!-- This wraps sidebar and main content -->

        <!-- Sidebar -->
        <aside class="w-64 bg-[#391E10] shadow-md p-6 hidden md:block">
            <h2 class="text-2xl font-bold mb-8"><a href="${pageContext.request.contextPath}/index" class="text-white hover:text-white underline">Admin Panel</a></h2>
            <nav class="space-y-4">
                <a href="${pageContext.request.contextPath}/admin" class="block px-4 py-2 rounded hover:bg-[#734128] transition">Dashboard</a>
                <a href="${pageContext.request.contextPath}/sellers" class="block px-4 py-2 rounded hover:bg-[#734128] transition">Manage Sellers</a>
                <a href="#" class="block px-4 py-2 rounded hover:bg-[#734128] transition">Manage Products</a>
                <a href="#" class="block px-4 py-2 rounded hover:bg-[#734128] transition">Reports</a>
                <a href="${pageContext.request.contextPath}/admin/logout" class="block px-4 py-2 rounded text-red-400 hover:text-red-500 hover:bg-red-100 transition">Logout</a>
            </nav>
        </aside>
