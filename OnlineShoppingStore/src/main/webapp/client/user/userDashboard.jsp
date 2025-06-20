<%@ page import="model.User" %>
<%@ include file="../partials/UserHeader.jsp" %>

<!-- Main Content -->
<main class="flex-1 p-10 text-black" style="background-color: #E2CEB1;">
    <h1 class="text-4xl font-bold mb-4 text-black  animate-fade">Welcome, <%= user.getName() %>!</h1>
    <p class="text-lg text-gray-600">This is your personalized dashboard.</p>

    <!-- Example content -->
    <div class="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="bg-[#FDFCE8] rounded-xl p-6 shadow hover:scale-105 transform transition border border-gray-200">
            <h3 class="text-xl font-semibold text-black  mb-2">Your Info</h3>
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Address:</strong> <%= user.getAddress() %></p>
        </div>
        <div class="bg-[#FDFCE8] rounded-xl p-6 shadow hover:scale-105 transform transition border border-gray-200">
            <h3 class="text-xl font-semibold text-black mb-2">Account Tools</h3>
            <ul class="list-disc ml-5 text-gray-700">
                <li>Update Profile</li>
                <li>View Purchase History</li>
                <li>Support</li>
            </ul>
        </div>
    </div>
</main>

<style>
    .animate-fade {
        animation: fadeIn 1s ease-in-out;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>

<%@ include file="../partials/UserFooter.jsp" %>
