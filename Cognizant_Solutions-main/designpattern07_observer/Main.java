package designpattern07_observer;

public class Main {
    public static void main(String[] args) {
        StockMarket stockMarket = new StockMarket();

        Observer user1 = new MobileApp("Yash");
        Observer user2 = new WebApp("InvestPro");

        stockMarket.registerObserver(user1);
        stockMarket.registerObserver(user2);

        stockMarket.setStockData("TATASTEEL", 145.70);
        stockMarket.setStockData("RELIANCE", 2680.00);
    }
}
