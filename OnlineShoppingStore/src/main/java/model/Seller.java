package model;

public class Seller {
    private int id;
    private String name;
    private String email;
    private String password;
    private String storeName;
    private boolean approved;

    // Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getStoreName() {
        return storeName;
    }

    public boolean isApproved() {
        return approved;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }
}
