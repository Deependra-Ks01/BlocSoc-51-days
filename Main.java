import java.util.Arrays;

public class Main {
  public static void main(String[] args) {
    String[] list1 = {"a", "b", "c"};
    String[] list2 = {"a", "b", "c"};

    System.out.println(Arrays.hashCode(list1));
    System.out.println(Arrays.hashCode(list2));
  }
}
