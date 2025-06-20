package servlet;

import model.Product;
import model.Seller;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

@WebServlet("/seller/products")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProductServlet extends HttpServlet {

	private final ProductService productService = new ProductService();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Seller seller = (session != null) ? (Seller) session.getAttribute("seller") : null;

		if (seller == null) {
			response.sendRedirect(request.getContextPath() + "/seller/login");
			return;
		}

		String mode = request.getParameter("mode");
		if (mode == null)
			mode = "list";
		request.setAttribute("mode", mode);

		if ("edit".equals(mode) || "view".equals(mode)) {
			int productId = Integer.parseInt(request.getParameter("id"));
			Product currentProduct = productService.getProductById(productId);
			request.setAttribute("currentProduct", currentProduct);
		}

		List<Product> sellerProducts = productService.getProductsBySellerId(seller.getId());
		request.setAttribute("products", sellerProducts);

		request.getRequestDispatcher("/client/seller/manageProducts.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Seller seller = (session != null) ? (Seller) session.getAttribute("seller") : null;

		if (seller == null) {
			response.sendRedirect(request.getContextPath() + "/seller/login");
			return;
		}

		String action = request.getParameter("action");
		String message;
		boolean isError = false;

		try {
			switch (action) {
			case "create":
				Product newProduct = extractProductFromRequest(request, seller.getId());
				if (productService.createProduct(newProduct)) {
					message = "Product created successfully.";
				} else {
					message = "Failed to create product.";
					isError = true;
				}
				break;

			case "update":
				Product updatedProduct = extractProductFromRequest(request, seller.getId());
				updatedProduct.setProductId(Integer.parseInt(request.getParameter("id")));
				if (productService.updateProduct(updatedProduct)) {
					message = "Product updated successfully.";
				} else {
					message = "Failed to update product.";
					isError = true;
				}
				break;

			case "delete":
				int deleteId = Integer.parseInt(request.getParameter("id"));
				if (productService.deleteProduct(deleteId)) {
					message = "Product deleted successfully.";
				} else {
					message = "Failed to delete product.";
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

		response.sendRedirect(request.getContextPath() + "/seller/products");
	}

	private Product extractProductFromRequest(HttpServletRequest request, int sellerId)
			throws IOException, ServletException {
		Product product = new Product();

		product.setProductName(request.getParameter("productName"));
		product.setDescription(request.getParameter("description"));
		product.setPrice(Double.parseDouble(request.getParameter("price")));
		product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
		product.setSellerId(sellerId);
		product.setActive("true".equalsIgnoreCase(request.getParameter("isActive")));

		// Handle image upload
		Part filePart = request.getPart("image");
		if (filePart != null && filePart.getSize() > 0) {
			String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			String uploadDir = getServletContext().getRealPath("/") + "client/assets/products";
			Files.createDirectories(Paths.get(uploadDir)); // Ensure folder exists

			String fullPath = uploadDir + File.separator + fileName;
			try (InputStream fileContent = filePart.getInputStream();
					OutputStream out = new FileOutputStream(fullPath)) {
				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = fileContent.read(buffer)) != -1) {
					out.write(buffer, 0, bytesRead);
				}
			}

			product.setImageUrl("client/assets/products/" + fileName);
		} else {
			// Retain the existing image if no new image is uploaded
			String existingImageUrl = request.getParameter("existingImageUrl");
			if (existingImageUrl != null && !existingImageUrl.isEmpty()) {
				product.setImageUrl(existingImageUrl);
			}
		}

		return product;
	}
}
