package designpattern04_adapter;

public class StripeGateway {
    public void doPayment(double amount) {
        System.out.println("Processing payment of ₹" + amount + " via Stripe.");
    }
}
