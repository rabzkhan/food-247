import 'package:flutter/material.dart';
import 'package:food/core/controllers/cart_controller.dart';
import 'package:food/views/cart/checkout_page.dart';
import 'package:get/get.dart';
import '../../core/components/dotted_divider.dart';
import '../../core/constants/app_defaults.dart';
import 'components/item_row.dart';
import 'components/single_cart_item_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartController cartController = Get.find();
  @override
  void initState() {
    cartController.getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(),
          SliverToBoxAdapter(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: cartController.cartItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SingleCartItemTile(cartItem: cartController.cartItems[index]);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                children: [
                  ItemRow(
                    title: 'Sub Total',
                    value: '\$ ${cartController.totalPrice.toStringAsFixed(2)}',
                  ),
                  const ItemRow(
                    title: 'Discount',
                    value: '\$ 0.00',
                  ),
                  const ItemRow(
                    title: 'Delivery Charge',
                    value: '\$ 0.00',
                  ),
                  const DottedDivider(),
                  ItemRow(
                    title: 'Total',
                    value: '\$ ${cartController.totalPrice.toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => CheckoutPage());
                  },
                  child: const Text('Checkout'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
