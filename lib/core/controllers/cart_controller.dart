import 'package:get/get.dart';
import '../database/database_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  RxList<CartModel> cartItems = <CartModel>[].obs;

  RxInt currentQuantiy = 1.obs;
  RxDouble totalPrice = 0.0.obs;

  void getCartItems() async {
    await DatabaseRepository.instance.getCartList().then((value) {
      cartItems.value = value;
    });
    calculateTotal();
  }

  void addToCart(CartModel cartItem) async {
    await DatabaseRepository.instance.insert(cart: cartItem);
  }

  void deleteCartItems(int productId) async {
    await DatabaseRepository.instance.delete(productId);
  }

  void updateCart(CartModel cartItem) async {
    await DatabaseRepository.instance.update(cartItem);
  }

  void calculateTotal() {
    double total = 0.0;
    for (CartModel item in cartItems) {
      total += item.quantity! * item.price!;
    }
    totalPrice.value = total;
  }
}
