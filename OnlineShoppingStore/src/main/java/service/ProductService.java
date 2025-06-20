package service;

import model.Product;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

	// Create Product
	public boolean createProduct(Product product) {
		String query = "INSERT INTO products (seller_id, product_name, description, price, quantity, image_url, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setInt(1, product.getSellerId());
			stmt.setString(2, product.getProductName());
			stmt.setString(3, product.getDescription());
			stmt.setDouble(4, product.getPrice());
			stmt.setInt(5, product.getQuantity());
			stmt.setString(6, product.getImageUrl());
			stmt.setBoolean(7, product.isActive()); // Use setActive() method
			return stmt.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Get All Products
	public List<Product> getAllProducts() {
		List<Product> products = new ArrayList<>();
		String query = "SELECT * FROM products";
		try (Connection conn = DBConnection.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				Product product = mapToProduct(rs);
				products.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return products;
	}

	// Get Product by ID
	public Product getProductById(int productId) {
		String query = "SELECT * FROM products WHERE product_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, productId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return mapToProduct(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// Get Products by Seller ID
	public List<Product> getProductsBySellerId(int sellerId) {
		List<Product> products = new ArrayList<>();
		String query = "SELECT * FROM products WHERE seller_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, sellerId);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getInt("product_id"));
				product.setProductName(rs.getString("product_name"));
				product.setDescription(rs.getString("description"));
				product.setPrice(rs.getDouble("price"));
				product.setQuantity(rs.getInt("quantity"));
				product.setImageUrl(rs.getString("image_url"));
				product.setSellerId(rs.getInt("seller_id"));
				product.setActive(rs.getBoolean("is_active")); // Use setActive() method
				products.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return products;
	}

	// Update Product
	public boolean updateProduct(Product product) {
		String query = "UPDATE products SET product_name = ?, description = ?, price = ?, quantity = ?, image_url = ?, is_active = ? WHERE product_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, product.getProductName());
			stmt.setString(2, product.getDescription());
			stmt.setDouble(3, product.getPrice());
			stmt.setInt(4, product.getQuantity());
			stmt.setString(5, product.getImageUrl());
			stmt.setBoolean(6, product.isActive()); // Use setActive() method
			stmt.setInt(7, product.getProductId());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Delete Product
	public boolean deleteProduct(int productId) {
		String query = "DELETE FROM products WHERE product_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, productId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Helper method to map ResultSet to Product object
	private Product mapToProduct(ResultSet rs) throws SQLException {
		Product product = new Product();
		product.setProductId(rs.getInt("product_id"));
		product.setSellerId(rs.getInt("seller_id"));
		product.setProductName(rs.getString("product_name"));
		product.setDescription(rs.getString("description"));
		product.setPrice(rs.getDouble("price"));
		product.setQuantity(rs.getInt("quantity"));
		product.setImageUrl(rs.getString("image_url"));
		product.setActive(rs.getBoolean("is_active")); // Use setActive() method
		return product;
	}
}
