package designpattern04_adapter;

public class PayPalGateway {
    public void makePayment(double amount) {
        System.out.println("Processing payment of ₹" + amount + " via PayPal.");
    }
}
