package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/logout")
public class UserLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the current session without creating a new one
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidate session to log the user out
            session.invalidate();

            // Optional message (use on login.jsp if needed)
            request.getSession(true).setAttribute("logoutMessage", "You have been logged out successfully.");
        }

        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/client/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Use GET for logout logic
        doGet(request, response);
    }
}
