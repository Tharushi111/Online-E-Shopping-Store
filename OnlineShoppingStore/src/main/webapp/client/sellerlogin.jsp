<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Seller Login - Online Shopping Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        // Fade-in animation
        window.onload = () => {
            const form = document.getElementById("login-form");
            form.classList.add("opacity-100", "translate-y-0");
        }
    </script>
    <style>
        .fade-in-start {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }
    </style>
</head>

<body class="bg-[#391E10] min-h-screen flex items-center justify-center text-gray-800 font-sans">


    <div class="w-full max-w-sm bg-[#E2CEB1] p-8 rounded-xl shadow-xl fade-in-start" id="login-form">
        <h2 class="text-3xl font-bold text-center mb-6 text-black">Seller Login</h2>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="bg-red-500 text-white px-4 py-2 rounded mb-4 text-center animate-pulse">
                ${error}
            </div>
        </c:if>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/seller/login" method="post" class="space-y-4">
    <input type="email" name="email" placeholder="Email Address" required
        class="w-full px-4 py-2 rounded bg-white text-gray-800 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500">

    <input type="password" name="password" placeholder="Password" required
        class="w-full px-4 py-2 rounded bg-white text-gray-800 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500">

    <button type="submit"
        class="w-full bg-[#734128] text-white hover:bg-[#C7A07A] transition-all font-semibold py-2 rounded shadow-lg transform hover:scale-105">
        Login
    </button>
</form>

        <p class="mt-6 text-center text-sm text-gray-400">
            
            <a href="${pageContext.request.contextPath}/index" class="text-blue-600 hover:text-blue-400 underline">Home</a>
        </p>
    </div>

</body>

</html>
