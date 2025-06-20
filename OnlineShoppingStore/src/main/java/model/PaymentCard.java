package model;

import java.sql.Timestamp;

public class PaymentCard {
    private int cardId;
    private int userId;
    private String cardholderName;
    private String cardNumberLast4;  // Store only the last 4 digits of the card number
    private String cardType;  // Enum type: 'Visa', 'MasterCard', 'Amex', 'Discover'
    private int expiryMonth;  // Expiry month (1-12)
    private int expiryYear;   // Expiry year (e.g., 2025)
    private Timestamp addedOn;  // Timestamp when the card was added
    private boolean isDefault;  // Indicates if the card is the default card for the user

    // Getters and Setters
    public int getCardId() {
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCardholderName() {
        return cardholderName;
    }

    public void setCardholderName(String cardholderName) {
        this.cardholderName = cardholderName;
    }

    public String getCardNumberLast4() {
        return cardNumberLast4;
    }

    public void setCardNumberLast4(String cardNumberLast4) {
        this.cardNumberLast4 = cardNumberLast4;
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public int getExpiryMonth() {
        return expiryMonth;
    }

    public void setExpiryMonth(int expiryMonth) {
        this.expiryMonth = expiryMonth;
    }

    public int getExpiryYear() {
        return expiryYear;
    }

    public void setExpiryYear(int expiryYear) {
        this.expiryYear = expiryYear;
    }

    public Timestamp getAddedOn() {
        return addedOn;
    }

    public void setAddedOn(Timestamp addedOn) {
        this.addedOn = addedOn;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }
}
