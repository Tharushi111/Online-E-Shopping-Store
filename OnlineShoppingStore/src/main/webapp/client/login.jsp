<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login - Online Shopping Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        window.onload = () => {
            const card = document.getElementById("login-card");
            card.classList.add("opacity-100", "translate-y-0");
        };
    </script>
    <style>
        .fade-slide {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.7s ease-in-out;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/style/styles.css">
</head>
<body class="bg-white min-h-screen flex items-center justify-center text-gray-800 font-sans">

	<div class="flex flex-col md:flex-row w-full max-w-4xl bg-white rounded-xl shadow-xl overflow-hidden border border-gray-300">
	
		 <div class="hidden md:block md:w-1/2">
	      <img src="${pageContext.request.contextPath}/client/images/login2.jpeg" class="w-full h-full object-cover" alt="Login Image" />
	    </div>
	    <div id="login-card" class="fade-slide w-full md:w-1/2 p-8 flex flex-col justify-center bg-[#E2CEB1]">

	        <h2 class="text-3xl font-bold text-center mb-6 text-black">Welcome Back</h2>
	
	        <!-- Success/Logout Message -->
	        <c:if test="${not empty logoutMessage}">
	            <div class="bg-green-100 text-green-800 px-4 py-2 rounded mb-4 text-center border border-green-300">
	                ${logoutMessage}
	                <c:remove var="logoutMessage" scope="session"/>
	            </div>
	        </c:if>
	
	        <!-- Error Message -->
	        <c:if test="${not empty error}">
	            <div class="bg-red-100 text-red-800 px-4 py-2 rounded mb-4 text-center border border-red-300 animate-pulse">
	                ${error}
	            </div>
	        </c:if>
	
	        <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-4">
	            <input type="email" name="email" placeholder="Email Address" required
	                   class="w-full px-4 py-2 rounded bg-gray-50 text-gray-800 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-400" />
	
	            <input type="password" name="password" placeholder="Password" required
	                   class="w-full px-4 py-2 rounded bg-gray-50 text-gray-800 border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-400" />
	
	            <button type="submit" class="btn-theme">
	                Log In
	            </button>
	        </form>
	
	        <p class="mt-6 text-center text-sm text-gray-600">
	            Don't have an account?
	            <a href="${pageContext.request.contextPath}/register" class="text-indigo-500 hover:underline">Create one</a>
	        </p>
	        <p class="mt-4 text-center text-sm text-gray-600"> 
	            <a href="${pageContext.request.contextPath}/index" class="text-indigo-600 hover:text-indigo-500 underline">Home</a>
	        </p>
	    </div>
	    </div>

</body>
</html>
