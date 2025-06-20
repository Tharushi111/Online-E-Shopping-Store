package servlet;

import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/profile")
public class UserProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/client/user/userProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        User sessionUser = (User) session.getAttribute("user");

        if ("update".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String password = request.getParameter("password");

            sessionUser.setName(name);
            sessionUser.setEmail(email);
            sessionUser.setPhone(phone);
            sessionUser.setAddress(address);
            if (password != null && !password.isEmpty()) {
                sessionUser.setPassword(password);
            }

            boolean success = userService.updateUser(sessionUser);
            if (success) {
                session.setAttribute("user", sessionUser);
                request.setAttribute("success", "Profile updated successfully.");
            } else {
                request.setAttribute("error", "Failed to update profile.");
            }

        } else if ("delete".equals(action)) {
            boolean deleted = userService.deleteUser(sessionUser.getId());
            if (deleted) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/login?deleted=true");
                return;
            } else {
                request.setAttribute("error", "Failed to delete account.");
            }
        }

        request.getRequestDispatcher("/client/user/userProfile.jsp").forward(request, response);
    }
}
