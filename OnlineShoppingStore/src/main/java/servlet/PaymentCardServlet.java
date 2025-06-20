package servlet;

import model.PaymentCard;
import service.PaymentCardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/payment-cards")
public class PaymentCardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentCardService cardService;

    @Override
    public void init() throws ServletException {
        cardService = new PaymentCardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String mode = request.getParameter("mode");
        if (mode == null) mode = "list";  // Default mode is 'list'
        request.setAttribute("mode", mode);

        // If the mode is 'add', show the form to add a new payment card
        if ("add".equals(mode)) {
            request.getRequestDispatcher("/client/user/paymentCards.jsp").forward(request, response);
            return;
        }

        // If the mode is 'edit', fetch the card details for editing
        if ("edit".equals(mode)) {
            int cardId = Integer.parseInt(request.getParameter("cardId"));
            PaymentCard currentCard = cardService.getCardById(cardId);
            request.setAttribute("currentCard", currentCard);
            request.getRequestDispatcher("/client/user/paymentCards.jsp").forward(request, response);
            return;
        }

        // Retrieve all cards for the user and pass them to the JSP
        List<PaymentCard> cards = cardService.getCardsByUserId(userId);
        request.setAttribute("cards", cards);

        // Forward to the page that lists all cards
        request.getRequestDispatcher("/client/user/paymentCards.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        String message;
        boolean isError = false;

        try {
            switch (action) {
                case "add":
                    // Gather all parameters to create a new payment card
                    String cardholderName = request.getParameter("cardholderName");
                    String cardNumber = request.getParameter("cardNumber");
                    String cardType = request.getParameter("cardType");
                    int expiryMonth = Integer.parseInt(request.getParameter("expiryMonth"));
                    int expiryYear = Integer.parseInt(request.getParameter("expiryYear"));
                    boolean isDefault = "on".equals(request.getParameter("isDefault"));

                    PaymentCard newCard = new PaymentCard();
                    newCard.setUserId(userId);
                    newCard.setCardholderName(cardholderName);
                    newCard.setCardNumberLast4(cardNumber.substring(cardNumber.length() - 4)); // Only last 4 digits
                    newCard.setCardType(cardType);
                    newCard.setExpiryMonth(expiryMonth);
                    newCard.setExpiryYear(expiryYear);
                    newCard.setDefault(isDefault);

                    // Set the new card as the default card if necessary
                    if (isDefault) {
                        cardService.setDefaultCard(userId, 0);
                    }

                    // Add the new payment card
                    if (cardService.addPaymentCard(newCard)) {
                        message = "Card added successfully.";
                    } else {
                        message = "Failed to add card.";
                        isError = true;
                    }
                    break;

                case "update":
                    // Update an existing payment card
                    int cardId = Integer.parseInt(request.getParameter("cardId"));
                    String updatedCardholderName = request.getParameter("cardholderName");
                    String updatedCardType = request.getParameter("cardType");
                    int updatedExpiryMonth = Integer.parseInt(request.getParameter("expiryMonth"));
                    int updatedExpiryYear = Integer.parseInt(request.getParameter("expiryYear"));
                    boolean updatedIsDefault = "on".equals(request.getParameter("isDefault"));

                    PaymentCard cardToUpdate = new PaymentCard();
                    cardToUpdate.setCardId(cardId);
                    cardToUpdate.setCardholderName(updatedCardholderName);
                    cardToUpdate.setCardType(updatedCardType);
                    cardToUpdate.setExpiryMonth(updatedExpiryMonth);
                    cardToUpdate.setExpiryYear(updatedExpiryYear);
                    cardToUpdate.setDefault(updatedIsDefault);

                    // Update the card details
                    if (cardToUpdate.isDefault()) {
                        cardService.setDefaultCard(userId, 0); // Unset previous default card if updating to default
                    }

                    if (cardService.updatePaymentCard(cardToUpdate)) {
                        message = "Card updated successfully.";
                    } else {
                        message = "Failed to update card.";
                        isError = true;
                    }
                    break;

                case "delete":
                    // Delete a card
                    int cardIdToDelete = Integer.parseInt(request.getParameter("cardId"));
                    if (cardService.deleteCard(cardIdToDelete)) {
                        message = "Card deleted successfully.";
                    } else {
                        message = "Failed to delete card.";
                        isError = true;
                    }
                    break;

                case "setDefault":
                    // Set a card as the default
                    int cardIdForDefault = Integer.parseInt(request.getParameter("cardId"));
                    if (cardService.setDefaultCard(userId, cardIdForDefault)) {
                        message = "Default card updated.";
                    } else {
                        message = "Failed to set default card.";
                        isError = true;
                    }
                    break;

                default:
                    message = "Unknown action.";
                    isError = true;
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
            isError = true;
        }

        // Set the message and redirect back to the cards page
        if (isError) {
            request.getSession().setAttribute("error", message);
        } else {
            request.getSession().setAttribute("success", message);
        }

        response.sendRedirect(request.getContextPath() + "/user/payment-cards");
    }
}
