package designpattern05_decorator;

public class Main {
    public static void main(String[] args) {
        Notifier notifier = new SlackNotifierDecorator(
                                new SMSNotifierDecorator(
                                    new EmailNotifier()
                                )
                             );

        notifier.send("System maintenance at 10 PM.");
    }
}
