package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/seller/logout")
public class SellerLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session, if available
        HttpSession session = request.getSession(false);

        // If session exists, invalidate it
        if (session != null) {
            session.invalidate();
        }

        // Redirect to the seller login page
        response.sendRedirect(request.getContextPath() + "/seller/login");
    }
}
