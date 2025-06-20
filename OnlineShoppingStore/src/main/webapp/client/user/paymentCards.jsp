<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<main class="p-6 w-full" style="background-color: #E2CEB1;">

    <!-- Success/Error Messages -->
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
        <h2 class="text-3xl font-bold text-black">My Payment Cards</h2>
        <a href="${pageContext.request.contextPath}/user/payment-cards?mode=add"
   class="bg-[#FDFCE8] hover:bg-[#C7A07A] text-black px-5 py-2 rounded-full text-sm font-semibold shadow transition">
    <i class="fas fa-plus mr-2"></i>Add New Card
</a>

        
    </div>

    <!-- LIST Mode -->
    <c:if test="${mode == 'list'}">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach items="${cards}" var="card">
                <div class="bg-[#FCFDE8] rounded-2xl shadow-lg p-6 hover:shadow-2xl transition-transform transform hover:scale-105 border border-gray-200">
                    <h3 class="text-lg font-semibold text-black mb-2">${card.cardType} Ending in ${card.cardNumberLast4}</h3>
                    <p class="text-gray-700 text-sm mb-1">Cardholder: ${card.cardholderName}</p>
                    <p class="text-gray-600 text-sm mb-1">Expires: ${card.expiryMonth}/${card.expiryYear}</p>

                    <div class="mt-4 flex justify-between items-center space-x-2">
                        <a href="${pageContext.request.contextPath}/user/payment-cards?mode=edit&cardId=${card.cardId}"
                           class="text-yellow-600 hover:text-yellow-700 text-sm">Edit</a>

                        <form action="${pageContext.request.contextPath}/user/payment-cards" method="POST"
                              onsubmit="return confirm('Delete this card?');">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="cardId" value="${card.cardId}"/>
                            <button type="submit" class="text-red-600 hover:text-red-700 text-sm">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty cards}">
            <div class="text-center text-blue-800 mt-10 text-lg">
                You have no saved cards. <br>
                <a href="${pageContext.request.contextPath}/user/payment-cards?mode=add" class="underline text-blue-600 hover:text-blue-500">Add one now!</a>
            </div>
        </c:if>
    </c:if>

    <!-- ADD / EDIT Mode -->
    <c:if test="${mode == 'add' || mode == 'edit'}">
        <div class="bg-[#FCFDE8] p-6 rounded-2xl shadow-md w-full max-w-md mx-auto mt-10 border border-gray-200">
            <h2 class="text-2xl font-bold mb-4 text-black">
                <c:choose>
                    <c:when test="${mode == 'add'}">Add New Card</c:when>
                    <c:otherwise>Edit Card</c:otherwise>
                </c:choose>
            </h2>

            <form action="${pageContext.request.contextPath}/user/payment-cards" method="POST">
                <input type="hidden" name="action" value="${mode == 'add' ? 'add' : 'update'}"/>
                <c:if test="${mode == 'edit'}">
                    <input type="hidden" name="cardId" value="${currentCard.cardId}"/>
                </c:if>

                <label class="block mb-2 text-sm font-semibold text-gray-700">Cardholder Name</label>
                <input type="text" name="cardholderName" required pattern="[A-Za-z\s]+"  required class="w-full border border-gray-300 p-2 mb-4 rounded text-gray-800"
                       value="${mode == 'edit' ? currentCard.cardholderName : ''}"/>

                <c:if test="${mode == 'add'}">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">Card Number</label>
                    <input type="text" name="cardNumber" required pattern="\d{16}" required class="w-full border border-gray-300 p-2 mb-4 rounded text-gray-800" maxlength="16"/>
                </c:if>

                <label class="block mb-2 text-sm font-semibold text-gray-700">Card Type</label>
                <select name="cardType" required class="w-full border border-gray-300 p-2 mb-4 rounded text-gray-800">
                    <option value="Visa" ${mode == 'edit' && currentCard.cardType == 'Visa' ? 'selected' : ''}>Visa</option>
                    <option value="MasterCard" ${mode == 'edit' && currentCard.cardType == 'MasterCard' ? 'selected' : ''}>MasterCard</option>
                    <option value="Amex" ${mode == 'edit' && currentCard.cardType == 'Amex' ? 'selected' : ''}>Amex</option>
                </select>

                <label class="block mb-2 text-sm font-semibold text-gray-700">Expiry Month</label>
                <input type="number" name="expiryMonth" min="1" max="12" required
                       class="w-full border border-gray-300 p-2 mb-4 rounded text-gray-800"
                       value="${mode == 'edit' ? currentCard.expiryMonth : ''}"/>

                <label class="block mb-2 text-sm font-semibold text-gray-700">Expiry Year</label>
                <input type="number" name="expiryYear" min="2024" required
                       class="w-full border border-gray-300 p-2 mb-6 rounded text-gray-800"
                       value="${mode == 'edit' ? currentCard.expiryYear : ''}"/>

                <div class="flex justify-between items-center">
                    <button type="submit" class="bg-[#734128] text-white px-4 py-2 rounded hover:bg-[#C7A07A] transition">


                        ${mode == 'add' ? 'Add Card' : 'Update Card'}
                    </button>
                    <a href="${pageContext.request.contextPath}/user/payment-cards" class="text-gray-600 text-sm underline ml-4">Cancel</a>
                </div>
            </form>
        </div>
    </c:if>

</main>

<%@ include file="../partials/UserFooter.jsp" %>
