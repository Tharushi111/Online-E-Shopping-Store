<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-white via-gray-100 to-gray-200 min-h-screen text-gray-800 flex font-sans">

    <!-- Sidebar -->
    <aside class="w-64 bg-#391E10 p-6 min-h-screen shadow-lg border-r border-gray-300" style="background-color: #391E10;">
        <h2 class="text-2xl font-bold mb-8 text-blue-800">
            <a href="${pageContext.request.contextPath}/index" class="hover:text-C7A07A underline text-white">User Panel</a>
        </h2>
        <nav class="space-y-4">
            <a href="${pageContext.request.contextPath}/client/user/userDashboard.jsp" class="block px-4 py-2 rounded hover:bg-[#734128] transition text-white">Dashboard</a>
            <a href="${pageContext.request.contextPath}/user/reviews" class="block px-4 py-2 rounded hover:bg-[#734128] transition text-white">Review</a>
            <a href="${pageContext.request.contextPath}/user/profile" class="block px-4 py-2 rounded hover:bg-[#734128] transition text-white">Profile</a>
            <a href="${pageContext.request.contextPath}/user/payment-cards" class="block px-4 py-2 rounded hover:bg-[#734128] transition text-white">Payment</a>
            <a href="${pageContext.request.contextPath}/user/logout" class="block px-4 py-2 text-red-600 hover:text-red-700 hover:bg-red-100 rounded transition text-white">Logout</a>
        </nav>
    </aside>
