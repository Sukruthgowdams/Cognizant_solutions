package designpattern08_strategy;

public class Main {
    public static void main(String[] args) {
        PaymentContext context = new PaymentContext();

        context.setPaymentStrategy(new CreditCardPayment("1234-5678-9012-3456"));
        context.processPayment(2000.00);

        context.setPaymentStrategy(new PayPalPayment("user@example.com"));
        context.processPayment(3500.50);
    }
}
