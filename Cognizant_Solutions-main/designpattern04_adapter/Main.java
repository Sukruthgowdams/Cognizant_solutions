package designpattern04_adapter;

public class Main {
    public static void main(String[] args) {
        PaymentProcessor paypal = new PayPalAdapter();
        PaymentProcessor stripe = new StripeAdapter();

        paypal.processPayment(1000.0);
        stripe.processPayment(2500.0);
    }
}
