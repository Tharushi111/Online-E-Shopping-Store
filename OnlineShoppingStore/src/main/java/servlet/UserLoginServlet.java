package servlet;

import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get login form inputs
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate user
        User user = userService.authenticate(email, password);

        if (user != null) {
            // Valid user found
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setMaxInactiveInterval(30 * 60); // 30 mins

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/client/user/userDashboard.jsp");
        } else {
            // Login failed
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/client/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // If already logged in, go to dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/client/user/userDashboard.jsp");
        } else {
            // Otherwise show login page
            request.getRequestDispatcher("/client/login.jsp").forward(request, response);
        }
    }
}
