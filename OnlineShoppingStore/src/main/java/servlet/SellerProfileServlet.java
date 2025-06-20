package servlet;

import model.Seller;
import service.SellerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/seller/profile")
public class SellerProfileServlet extends HttpServlet {

    private final SellerService sellerService = new SellerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the session and check if the seller is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("seller") == null) {
            response.sendRedirect(request.getContextPath() + "/seller/login");
            return;
        }

        // Forward to the profile page
        request.getRequestDispatcher("/client/seller/sellerProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the session and check if the seller is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("seller") == null) {
            response.sendRedirect(request.getContextPath() + "/seller/login");
            return;
        }

        // Get the logged-in seller from the session
        Seller seller = (Seller) session.getAttribute("seller");
        String action = request.getParameter("action");
        String message = "";
        boolean isError = false;

        try {
            switch (action) {
                case "update":
                    // Update seller profile (without changing password)
                    seller.setName(request.getParameter("name"));
                    seller.setEmail(request.getParameter("email"));
                    seller.setStoreName(request.getParameter("storeName"));
                    seller.setApproved("true".equalsIgnoreCase(request.getParameter("approved")));
                    seller.setPassword(request.getParameter("password"));

                    boolean updated = sellerService.updateSeller(seller);
                    if (updated) {
                        message = "Profile updated successfully.";
                        session.setAttribute("seller", seller); // Update seller object in session
                    } else {
                        message = "Failed to update profile.";
                        isError = true;
                    }
                    break;

                case "delete":
                    // Delete the seller account
                    boolean deleted = sellerService.deleteSeller(seller.getId());
                    if (deleted) {
                        // Invalidate the session and log out the seller
                        session.invalidate();
                        response.sendRedirect(request.getContextPath() + "/seller/login?deleted=true");
                        return;
                    } else {
                        message = "Failed to delete the account.";
                        isError = true;
                    }
                    break;

                default:
                    message = "Unknown action.";
                    isError = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
            isError = true;
        }

        // Set success or error message in session
        if (isError) {
            session.setAttribute("error", message);
        } else {
            session.setAttribute("success", message);
        }

        // Forward back to the profile page
        request.getRequestDispatcher("/client/seller/sellerProfile.jsp").forward(request, response);
    }
}
