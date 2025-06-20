package servlet;

import model.Seller;
import service.SellerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/seller/login")
public class SellerLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final SellerService sellerService = new SellerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check for existing session
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("seller") != null) {
            response.sendRedirect(request.getContextPath() + "/client/seller/sellerDashboard.jsp");
            return;
        }

        // Authenticate
        Seller seller = sellerService.login(email, password);

        if (seller != null) {
            // Create session
            session = request.getSession(true);
            session.setAttribute("seller", seller);
            session.setAttribute("sellerId", seller.getId());
            session.setAttribute("sellerName", seller.getName());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            response.sendRedirect(request.getContextPath() + "/client/seller/sellerDashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/client/sellerlogin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("seller") != null) {
            response.sendRedirect(request.getContextPath() + "/client/seller/sellerDashboard.jsp");
        } else {
            request.getRequestDispatcher("/client/sellerlogin.jsp").forward(request, response);
        }
    }
}
