package servlet;

import model.Admin;
import service.AdminService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private AdminService adminService = new AdminService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check if session already exists
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        // Authenticate admin
        Admin admin = adminService.getAdminByEmail(email);

        if (admin != null && admin.getPassword().equals(password)) {
            // Create new session
            session = request.getSession(true);
            session.setAttribute("admin", admin);
            session.setAttribute("name", admin.getName());
            session.setAttribute("email", admin.getEmail());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // Redirect to admin dashboard
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            // Authentication failed
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/admin/AdminLogin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            request.getRequestDispatcher("/admin/AdminLogin.jsp").forward(request, response);
        }
    }
}
