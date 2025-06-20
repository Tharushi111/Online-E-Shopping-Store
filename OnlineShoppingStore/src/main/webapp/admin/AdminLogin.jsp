<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Online Shopping Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#391E10] to-black min-h-screen flex items-center justify-center text-white">

    <div class="bg-[#E2CEB1] p-8 rounded-2xl shadow-xl w-full max-w-md transform transition duration-500 hover:scale-105">
        <h2 class="text-3xl font-bold text-center text-black mb-6 animate-fade-in-down">Admin Login</h2>

        <form action="${pageContext.request.contextPath}/admin/login" method="post" class="space-y-6 animate-fade-in-up">
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="text-red-500 text-sm text-center"><%= error %></div>
            <% } %>

            <div>
                <label for="email" class="block mb-2 text-black font-medium">Email</label>
                <input type="email" id="email" name="email"
                       class="w-full px-4 py-2 text-black rounded-lg bg-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       required autofocus>
            </div>

            <div>
                <label for="password" class="block mb-2 text-black font-medium">Password</label>
                <input type="password" id="password" name="password"
                       class="w-full px-4 py-2 text-black rounded-lg bg-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       required>
            </div>

            <button type="submit"
                    class="w-full py-2 px-4 bg-[#391E10] hover:[#734128] transition duration-300 ease-in-out text-white font-black rounded-lg shadow-md hover:shadow-lg">
                Login
            </button>
        </form>

        <p class="mt-6 text-sm text-center text-gray-700">
            © 2025 Online Shopping Store. All rights reserved.
        </p>
        
                <p class="mt-6 text-center text-sm text-gray-400"> 
            <a href="${pageContext.request.contextPath}/index" class="text-purple-400 hover:text-purple-300 underline">Home</a>
        </p>
    </div>

    <style>
        .animate-fade-in-down {
            animation: fadeInDown 0.6s ease-out both;
        }

        .animate-fade-in-up {
            animation: fadeInUp 0.6s ease-out both;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

</body>
</html>
