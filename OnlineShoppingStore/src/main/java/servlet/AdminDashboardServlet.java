package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Redirect to login if not authenticated
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // TODO: You can fetch dashboard data here from services and set as request attributes
        // Example:
        // request.setAttribute("totalUsers", userService.getTotalUserCount());

        request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
    }
}
