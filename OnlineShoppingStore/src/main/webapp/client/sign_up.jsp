<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Sign Up - Online Shopping Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        window.onload = () => {
            const form = document.getElementById("signup-form");
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/style/styles.css">
</head>
<body class="bg-[#734128] min-h-screen flex items-center justify-center text-gray-800 font-sans">


    <div class="w-full max-w-md bg-[#E2CEB1] p-8 rounded-xl shadow-xl fade-in-start" id="signup-form">

        <h2 class="text-3xl font-bold text-center mb-6 text-black">Create Your Account</h2>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="bg-red-500 text-white px-4 py-2 rounded mb-4 text-center animate-pulse">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-4">
    <input type="text" name="name" placeholder="Full Name" required
           class="w-full px-4 py-2 rounded bg-white text-gray-800 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500"/>

    <input type="email" name="email" placeholder="Email Address" required
           class="w-full px-4 py-2 rounded bg-white text-gray-800 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500" />

    <input type="password" name="password" placeholder="Password" required
           class="w-full px-4 py-2 rounded bg-white text-gray-800 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500" />

    <textarea name="address" placeholder="Address" rows="3" required
              class="w-full px-4 py-2 rounded bg-white text-gray-800 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500"></textarea>

    <button type="submit" class="btn-theme">
        Sign Up
    </button>
</form>


        <p class="mt-6 text-center text-sm text-gray-800">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login" class="text-black hover:text-purple-800 underline">Log in</a>
        </p>
        <p class="mt-6 text-center text-sm text-gray-400"> 
            <a href="${pageContext.request.contextPath}/index" class="text-black hover:text-purple-800 underline">Home</a>
        </p>
    </div>

</body>
</html>
