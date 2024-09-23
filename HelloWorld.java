import java.util.ArrayList;


public class HelloWorld {
    public static void main(String...args) {
        System.out.println("Hello World!");
        ArrayList<String> shoppingList = new ArrayList<>();
        shoppingList.add("Milk");
        shoppingList.add("Bread");
        shoppingList.add("Pasta");
        shoppingList.stream()
            .forEach(System.out::println);
        
    }
}
