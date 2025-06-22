package designpattern07_observer;

public class WebApp implements Observer {
    private String username;

    public WebApp(String username) {
        this.username = username;
    }

    public void update(String stockName, double newPrice) {
        System.out.println("Web - " + username + ": " + stockName + " updated to ₹" + newPrice);
    }
}
