<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<main class="p-8 w-full" style = "background : #E2CEB1">
    <div class="bg-[#FDFCE8] p-6 rounded-lg shadow-lg max-w-3xl mx-auto transition transform hover:scale-[1.01] border border-gray-200">
        <h2 class="text-3xl font-semibold mb-6 text-black border-b border-gray-300 pb-2">My Profile</h2>

        <!-- Read-only profile -->
        <div id="profileView">
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <p class="text-gray-500">Full Name</p>
                    <p class="text-gray-900 text-lg font-medium mt-1">${user.name}</p>
                </div>
                <div>
                    <p class="text-gray-500">Email</p>
                    <p class="text-gray-900 text-lg font-medium mt-1">${user.email}</p>
                </div>
                <div>
                    <p class="text-gray-500">Address</p>
                    <p class="text-gray-900 text-lg font-medium mt-1">${user.address}</p>
                </div>
            </div>

            <div class="mt-6 flex justify-between">
                <button onclick="toggleEdit()" class="bg-blue-800 hover:bg-blue-900 text-white px-5 py-2 rounded-lg transition">Edit Profile</button>
                <form method="post" action="${pageContext.request.contextPath}/user/profile" onsubmit="return confirm('Are you sure you want to delete your account?')">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-5 py-2 rounded-lg transition">Delete Account</button>
                </form>
            </div>
        </div>

        <!-- Edit form -->
        <form id="profileEditForm" method="post" action="${pageContext.request.contextPath}/user/profile" class="hidden space-y-4 mt-4">
            <input type="hidden" name="action" value="update">
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <input type="text" name="name" value="${user.name}" placeholder="Full Name" required
                       class="w-full px-4 py-2 rounded bg-gray-50 text-gray-900 border border-gray-300 focus:outline-none" />

                <input type="email" name="email" value="${user.email}" placeholder="Email Address" required
                       class="w-full px-4 py-2 rounded bg-gray-50 text-gray-900 border border-gray-300 focus:outline-none" />

                <input type="password" name="password" placeholder="New Password (leave blank to keep same)"
                       class="w-full px-4 py-2 rounded bg-gray-50 text-gray-900 border border-gray-300 focus:outline-none" />
            </div>

            <textarea name="address" placeholder="Address" rows="3"
                      class="w-full px-4 py-2 rounded bg-gray-50 text-gray-900 border border-gray-300 focus:outline-none">${user.address}</textarea>

            <div class="flex justify-between">
                <button type="button" onclick="toggleEdit()" class="bg-gray-300 hover:bg-gray-400 text-gray-800 px-4 py-2 rounded">Cancel</button>
                <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded">Save Changes</button>
            </div>
        </form>
    </div>
</main>

<%@ include file="../partials/UserFooter.jsp" %>

<script>
    function toggleEdit() {
        const view = document.getElementById("profileView");
        const form = document.getElementById("profileEditForm");
        view.classList.toggle("hidden");
        form.classList.toggle("hidden");
    }
</script>
