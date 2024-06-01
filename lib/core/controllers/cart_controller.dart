import 'package:food/core/components/toast_message.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  RxInt currentQuantiy = 1.obs;
  RxDouble totalPrice = 0.0.obs;

  RxList<CartModel> cartItems = <CartModel>[].obs;

  addToCart(CartModel item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);
    if (index == -1) {
      cartItems.add(item);
      showToast("Added to cart");
    } else {
      showToast("Already in cart!");
    }
    calculateTotal();
  }

  void updateCart(CartModel item, int quantity) {
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);
    if (index != -1) {
      CartModel tempItem = CartModel(
          productId: item.productId,
          title: item.title,
          description: item.description,
          imageUrl: item.imageUrl,
          price: item.price!,
          quantity: quantity,
          size: item.size,
          extraItems: item.extraItems);
      cartItems[index] = tempItem;
      showToast("Cart updated");
      calculateTotal();
    } else {
      showToast("Item not found in cart");
    }
    calculateTotal();
  }

  deleteFromCart(CartModel item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);
    cartItems.removeAt(index);
    showToast("Item removed from the cart!");
    calculateTotal();
  }

  void calculateTotal() {
    double total = 0.0;
    for (CartModel item in cartItems) {
      total += item.price! * item.quantity!;
    }

    totalPrice.value = total;
  }

  clearCart() {
    cartItems.clear();
    currentQuantiy = 1.obs;
    totalPrice = 0.0.obs;
  }
}
