package servlet;

import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class UserRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form values
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Create user object
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setAddress(address);
        user.setActive(true);  // Default to active on registration

        boolean success = userService.createUser(user);

        if (success) {
            // Registration successful → redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Failed → return to sign up with error
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/client/sign_up.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show sign-up page
        request.getRequestDispatcher("/client/sign_up.jsp").forward(request, response);
    }
}
