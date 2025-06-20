package servlet;

import model.Seller;
import service.SellerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/sellers")
public class SellerServlet extends HttpServlet {

    private SellerService sellerService;

    @Override
    public void init() {
        sellerService = new SellerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        if ("approve".equalsIgnoreCase(action)) {
            try {
                int approveId = Integer.parseInt(request.getParameter("id"));
                boolean success = sellerService.approveSeller(approveId);

                if (success) {
                    session.setAttribute("success", "Seller approved successfully.");
                } else {
                    session.setAttribute("error", "Failed to approve seller.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/sellers");
            return;
        }

        String mode = request.getParameter("mode");
        if (mode == null) mode = "list";
        request.setAttribute("mode", mode);

        if ("edit".equals(mode) || "view".equals(mode)) {
            int sellerId = Integer.parseInt(request.getParameter("id"));
            Seller currentSeller = sellerService.getSellerById(sellerId);
            request.setAttribute("currentSeller", currentSeller);
        }

        List<Seller> sellers = sellerService.getAllSellers();
        request.setAttribute("sellers", sellers);

        request.getRequestDispatcher("/admin/manageSellers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        String message;
        boolean isError = false;

        try {
            switch (action) {
                case "create":
                    Seller newSeller = extractSellerFromRequest(request);
                    newSeller.setApproved(false);
                    if (sellerService.createSeller(newSeller)) {
                        message = "Seller created successfully.";
                    } else {
                        message = "Failed to create seller.";
                        isError = true;
                    }
                    break;

                case "update":
                    Seller updatedSeller = extractSellerFromRequest(request);
                    updatedSeller.setId(Integer.parseInt(request.getParameter("id")));
                    if (sellerService.updateSeller(updatedSeller)) {
                        message = "Seller updated successfully.";
                    } else {
                        message = "Failed to update seller.";
                        isError = true;
                    }
                    break;

                case "approve":
                    int approveId = Integer.parseInt(request.getParameter("id"));
                    if (sellerService.approveSeller(approveId)) {
                        message = "Seller approved successfully.";
                    } else {
                        message = "Failed to approve seller.";
                        isError = true;
                    }
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    if (sellerService.deleteSeller(deleteId)) {
                        message = "Seller deleted successfully.";
                    } else {
                        message = "Failed to delete seller.";
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

        if (isError) {
            session.setAttribute("error", message);
        } else {
            session.setAttribute("success", message);
        }

        response.sendRedirect(request.getContextPath() + "/sellers");
    }

    private Seller extractSellerFromRequest(HttpServletRequest request) {
        Seller seller = new Seller();
        seller.setName(request.getParameter("name"));
        seller.setEmail(request.getParameter("email"));
        seller.setPassword(request.getParameter("password"));
        seller.setStoreName(request.getParameter("storeName"));
        seller.setApproved("true".equalsIgnoreCase(request.getParameter("approved")));
        return seller;
    }
}
