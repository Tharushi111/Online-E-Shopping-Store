package service;

import model.PaymentCard;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentCardService {

    // Add New Payment Card
    public boolean addPaymentCard(PaymentCard card) {
        String query = "INSERT INTO PaymentCard (user_id, cardholder_name, card_number_last4, card_type, expiry_month, expiry_year, is_default) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, card.getUserId());
            stmt.setString(2, card.getCardholderName());
            stmt.setString(3, card.getCardNumberLast4());
            stmt.setString(4, card.getCardType());
            stmt.setInt(5, card.getExpiryMonth());
            stmt.setInt(6, card.getExpiryYear());
            stmt.setBoolean(7, card.isDefault());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update Payment Card
    public boolean updatePaymentCard(PaymentCard card) {
        String query = "UPDATE PaymentCard SET cardholder_name = ?, card_type = ?, expiry_month = ?, expiry_year = ?, is_default = ? WHERE card_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, card.getCardholderName());
            stmt.setString(2, card.getCardType());
            stmt.setInt(3, card.getExpiryMonth());
            stmt.setInt(4, card.getExpiryYear());
            stmt.setBoolean(5, card.isDefault());
            stmt.setInt(6, card.getCardId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get All Cards by User ID
    public List<PaymentCard> getCardsByUserId(int userId) {
        List<PaymentCard> cards = new ArrayList<>();
        String query = "SELECT * FROM PaymentCard WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                cards.add(mapResultSetToPaymentCard(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cards;
    }

    // Get Card by ID
    public PaymentCard getCardById(int cardId) {
        String query = "SELECT * FROM PaymentCard WHERE card_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, cardId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToPaymentCard(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Delete Card
    public boolean deleteCard(int cardId) {
        String query = "DELETE FROM PaymentCard WHERE card_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, cardId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Set Default Card (Only one default per user)
    public boolean setDefaultCard(int userId, int cardId) {
        String unsetQuery = "UPDATE PaymentCard SET is_default = FALSE WHERE user_id = ?";
        String setQuery = "UPDATE PaymentCard SET is_default = TRUE WHERE card_id = ?";

        try (Connection connection = DBConnection.getConnection()) {
            connection.setAutoCommit(false);

            try (PreparedStatement unsetStmt = connection.prepareStatement(unsetQuery);
                 PreparedStatement setStmt = connection.prepareStatement(setQuery)) {

                unsetStmt.setInt(1, userId);
                unsetStmt.executeUpdate();

                if (cardId != 0) {
                    setStmt.setInt(1, cardId);
                    setStmt.executeUpdate();
                }

                connection.commit();
                return true;

            } catch (SQLException e) {
                connection.rollback();
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper Method: Map ResultSet to PaymentCard
    private PaymentCard mapResultSetToPaymentCard(ResultSet rs) throws SQLException {
        PaymentCard card = new PaymentCard();
        card.setCardId(rs.getInt("card_id"));
        card.setUserId(rs.getInt("user_id"));
        card.setCardholderName(rs.getString("cardholder_name"));
        card.setCardNumberLast4(rs.getString("card_number_last4"));
        card.setCardType(rs.getString("card_type"));
        card.setExpiryMonth(rs.getInt("expiry_month"));
        card.setExpiryYear(rs.getInt("expiry_year"));
        card.setAddedOn(rs.getTimestamp("added_on"));
        card.setDefault(rs.getBoolean("is_default"));
        return card;
    }
}
