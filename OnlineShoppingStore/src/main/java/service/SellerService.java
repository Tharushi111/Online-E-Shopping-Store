package service;

import model.Seller;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SellerService {

    // Create Seller
    public boolean createSeller(Seller seller) {
        String query = "INSERT INTO sellers (name, email, password, store_name, approved) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, seller.getName());
            stmt.setString(2, seller.getEmail());
            stmt.setString(3, seller.getPassword());
            stmt.setString(4, seller.getStoreName());
            stmt.setBoolean(5, seller.isApproved());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Method to authenticate a seller during login
    public Seller login(String email, String password) {
        String query = "SELECT * FROM sellers WHERE email = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
             
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // If a seller with the matching email and password is found
                Seller seller = new Seller();
                seller.setId(rs.getInt("seller_id"));
                seller.setName(rs.getString("name"));
                seller.setEmail(rs.getString("email"));
                seller.setPassword(rs.getString("password"));
                seller.setStoreName(rs.getString("store_name"));
                seller.setApproved(rs.getBoolean("approved"));
                return seller; // Return the seller object
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null; // If no seller found or any error occurs
    }

    // Get Seller by ID
    public Seller getSellerById(int id) {
        String query = "SELECT * FROM sellers WHERE seller_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultToSeller(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get Seller by Email
    public Seller getSellerByEmail(String email) {
        String query = "SELECT * FROM sellers WHERE email = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultToSeller(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Sellers
    public List<Seller> getAllSellers() {
        List<Seller> sellers = new ArrayList<>();
        String query = "SELECT * FROM sellers";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                sellers.add(mapResultToSeller(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sellers;
    }

    // Update Seller Info (without password change)
    public boolean updateSeller(Seller seller) {
        String query = "UPDATE sellers SET name = ?, email = ?, store_name = ?, approved = ? WHERE seller_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, seller.getName());
            stmt.setString(2, seller.getEmail());
            stmt.setString(3, seller.getStoreName());
            stmt.setBoolean(4, seller.isApproved());
            stmt.setInt(5, seller.getId());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Approve Seller
    public boolean approveSeller(int sellerId) {
        String query = "UPDATE sellers SET approved = TRUE WHERE seller_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, sellerId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Seller
    public boolean deleteSeller(int sellerId) {
        String query = "DELETE FROM sellers WHERE seller_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, sellerId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper method to map ResultSet to Seller object
    private Seller mapResultToSeller(ResultSet rs) throws SQLException {
        Seller seller = new Seller();
        seller.setId(rs.getInt("seller_id"));
        seller.setName(rs.getString("name"));
        seller.setEmail(rs.getString("email"));
        seller.setPassword(rs.getString("password"));
        seller.setStoreName(rs.getString("store_name"));
        seller.setApproved(rs.getBoolean("approved"));
        return seller;
    }
}
