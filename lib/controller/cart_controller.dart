import 'package:get/get.dart';

class CartItem {
  final String title;
  final String subtitle;
  final int price;
  int quantity;

  CartItem({
    required this.title,
    required this.subtitle,
    required this.price,
    this.quantity = 1,
  });

  int get totalPrice => price * quantity;
}

class CartController extends GetxController {
  // Observable cart items
  final cartItems = <CartItem>[
    CartItem(title: "FAST FOOD", subtitle: "French Fries", price: 12000),
    CartItem(title: "BURGER", subtitle: "Cheese Burger", price: 25000),
    CartItem(title: "FAST FOOD", subtitle: "Fried Chicken", price: 18000),
  ].obs;

  // Computed total price
  int get totalPrice => cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  // Check if cart is empty
  bool get isEmpty => cartItems.isEmpty;

  void increaseQuantity(int index) {
    if (index < cartItems.length) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(int index) {
    if (index < cartItems.length && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    }
  }

  void removeItem(int index) {
    if (index < cartItems.length) {
      cartItems.removeAt(index);
    }
  }

  void clearCart() {
    cartItems.clear();
  }
}