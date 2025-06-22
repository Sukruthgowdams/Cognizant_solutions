package Exercise_2Ecommerce;

public class Main {
    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "iPhone", "Electronics"),
            new Product(102, "T-Shirt", "Apparel"),
            new Product(103, "Laptop", "Electronics"),
            new Product(104, "Shoes", "Footwear"),
            new Product(105, "Watch", "Accessories")
        };

        System.out.println("--- Linear Search ---");
        Product result1 = SearchEngine.linearSearch(products, "Laptop");
        System.out.println(result1 != null ? result1 : "Product not found");

        System.out.println("\n--- Binary Search ---");
        SearchEngine.sortByName(products);
        Product result2 = SearchEngine.binarySearch(products, "Laptop");
        System.out.println(result2 != null ? result2 : "Product not found");
    }
}
