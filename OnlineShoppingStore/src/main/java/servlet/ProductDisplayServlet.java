package servlet;

import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/products")
public class ProductDisplayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductService productService;

	@Override
	public void init() throws ServletException {
		productService = new ProductService(); // Initialize ProductService to interact with DB
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get all products from the database
		List<Product> products = productService.getAllProducts();

		// Set products as a request attribute to be used in the JSP
		request.setAttribute("products", products);

		// Forward the request to the product display JSP page
		request.getRequestDispatcher("/client/productList.jsp").forward(request, response);
	}
}
