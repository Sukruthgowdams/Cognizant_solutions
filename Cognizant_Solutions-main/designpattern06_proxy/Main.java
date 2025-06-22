package designpattern06_proxy;

public class Main {
    public static void main(String[] args) {
        Image image1 = new ProxyImage("car.jpg");
        Image image2 = new ProxyImage("dog.png");

        System.out.println("--- First time loading ---");
        image1.display(); // loads & displays

        System.out.println("--- Second time, no loading ---");
        image1.display(); // only displays

        System.out.println("--- Load second image ---");
        image2.display(); // loads & displays
    }
}
