package designpattern04_adapter;

public class PayPalAdapter implements PaymentProcessor {
    private PayPalGateway gateway = new PayPalGateway();

    public void processPayment(double amount) {
        gateway.makePayment(amount);
    }
}
