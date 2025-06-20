<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<main class="p-6 w-full" style="background: #E2CEB1">

    <!-- Flash Messages -->
    <c:if test="${not empty sessionScope.success}">
        <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6 animate-bounce rounded">
            <p>${sessionScope.success}</p>
            <c:remove var="success" scope="session"/>
        </div>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6 animate-pulse rounded">
            <p>${sessionScope.error}</p>
            <c:remove var="error" scope="session"/>
        </div>
    </c:if>

    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-3xl font-bold text-black">My Reviews</h2>
        <a href="${pageContext.request.contextPath}/user/reviews?mode=add"
           class="bg-[#FDFCE8] hover:bg-[#C7A07A] text-black px-5 py-2 rounded-full text-sm font-semibold shadow transition">
            <i class="fas fa-plus mr-2"></i>Write a Review
        </a>
    </div>

    <!-- LIST Mode -->
    <c:if test="${mode == 'list'}">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach items="${reviews}" var="review">
                <div class="bg-white rounded-2xl shadow-lg p-6 hover:shadow-2xl transition-transform transform hover:scale-105 border border-gray-200">
                    <h3 class="text-lg font-semibold text-blue-800 mb-1">Rating: ${review.rating} ★</h3>
                    <p class="text-gray-800 mb-2">${review.comment}</p>
                    <p class="text-sm text-gray-600 mb-2">Product ID: ${review.productId}</p>
                    <p class="text-xs text-gray-500">Posted: ${review.createdAt}</p>

                    <div class="mt-4 flex justify-between items-center">
                        <a href="${pageContext.request.contextPath}/user/reviews?mode=view&id=${review.reviewId}" class="text-blue-600 hover:underline text-sm">View</a>
                        <a href="${pageContext.request.contextPath}/user/reviews?mode=edit&id=${review.reviewId}" class="text-yellow-600 hover:underline text-sm">Edit</a>
                        <form action="${pageContext.request.contextPath}/user/reviews" method="POST" onsubmit="return confirm('Delete this review?');">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="id" value="${review.reviewId}"/>
                            <button type="submit" class="text-red-600 hover:underline text-sm">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty reviews}">
                <div class="text-center text-blue-800 text-lg mt-10 col-span-full">
                    You haven't posted any reviews yet. <br>
                    <a href="${pageContext.request.contextPath}/user/reviews?mode=add" class="underline text-blue-600 hover:text-blue-500">Write one now!</a>
                </div>
            </c:if>
        </div>
    </c:if>

    <!-- ADD / EDIT Mode -->
    <c:if test="${mode == 'add' || mode == 'edit'}">
        <div class="bg-white p-6 rounded-2xl shadow-md w-full max-w-lg mx-auto mt-10 border border-gray-200">
            <h2 class="text-2xl font-bold mb-4 text-blue-800">
                <c:choose>
                    <c:when test="${mode == 'add'}">Write a Review</c:when>
                    <c:otherwise>Edit Review</c:otherwise>
                </c:choose>
            </h2>

            <form id="reviewForm" action="${pageContext.request.contextPath}/user/reviews" method="POST">
                <input type="hidden" name="action" value="${mode == 'add' ? 'create' : 'update'}"/>
                <c:if test="${mode == 'edit'}">
                    <input type="hidden" name="id" value="${currentReview.reviewId}"/>
                </c:if>

                <label class="block mb-2 text-sm font-semibold text-gray-700">Product ID</label>
                <input type="number" name="productId" class="w-full border border-gray-300 p-2 mb-4 rounded text-gray-800 bg-white"
                       value="${mode == 'edit' ? currentReview.productId : ''}" ${mode == 'edit' ? "readonly" : ""}/>

                <label class="block mb-2 text-sm font-semibold text-gray-700">Rating (1 to 5)</label>
                <input type="number" name="rating" class="w-full border border-gray-300 p-2 mb-4 rounded text-gray-800 bg-white"
                       value="${mode == 'edit' ? currentReview.rating : ''}"/>

                <label class="block mb-2 text-sm font-semibold text-gray-700">Comment</label>
                <textarea name="comment" rows="4" class="w-full border border-gray-300 p-2 mb-6 rounded text-gray-800 bg-white">${mode == 'edit' ? currentReview.comment : ''}</textarea>

                <div class="flex justify-between items-center">
                    <button type="submit"
                            class="bg-blue-800 text-white px-4 py-2 rounded hover:bg-blue-900 transition">
                        ${mode == 'add' ? 'Submit Review' : 'Update Review'}
                    </button>
                    <a href="${pageContext.request.contextPath}/user/reviews" class="text-gray-700 text-sm underline ml-4">Cancel</a>
                </div>
            </form>
        </div>
    </c:if>

    <!-- VIEW Mode -->
    <c:if test="${mode == 'view'}">
        <div class="bg-white p-6 rounded-xl shadow w-full max-w-xl mx-auto mt-10 text-gray-900 border border-gray-200">
            <h2 class="text-2xl font-bold text-blue-800 mb-4">Review Details</h2>

            <p class="mb-2"><strong>Product ID:</strong> ${currentReview.productId}</p>
            <p class="mb-2"><strong>Rating:</strong> ${currentReview.rating} ★</p>
            <p class="mb-2"><strong>Comment:</strong></p>
            <p class="border border-gray-300 p-3 rounded bg-white mt-1">${currentReview.comment}</p>
            <p class="text-sm mt-4"><strong>Created At:</strong> ${currentReview.createdAt}</p>
            <p class="text-sm"><strong>Updated At:</strong> ${currentReview.updatedAt}</p>

            <div class="mt-6">
                <a href="${pageContext.request.contextPath}/user/reviews" class="text-blue-600 hover:underline">← Back to Reviews</a>
            </div>
        </div>
    </c:if>

    <!-- JavaScript Validation -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.getElementById("reviewForm");
            if (form) {
                form.addEventListener("submit", function (e) {
                    const rating = parseInt(form.rating.value);
                    const productId = parseInt(form.productId.value);
                    const comment = form.comment.value.trim();

                    if (isNaN(productId) || productId <= 0) {
                        alert("Please enter a valid Product ID.");
                        form.productId.focus();
                        e.preventDefault();
                        return;
                    }

                    if (isNaN(rating) || rating < 1 || rating > 5) {
                        alert("Rating must be a number between 1 and 5.");
                        form.rating.focus();
                        e.preventDefault();
                        return;
                    }

                    if (comment.length < 5) {
                        alert("Comment must be at least 5 characters long.");
                        form.comment.focus();
                        e.preventDefault();
                        return;
                    }
                });
            }
        });
    </script>

</main>

<%@ include file="../partials/UserFooter.jsp" %>