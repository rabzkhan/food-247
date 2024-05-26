import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/cart_controller.dart';
import 'package:food/views/checkout/checkout_page.dart';
import 'package:get/get.dart';
import '../../core/components/dotted_divider.dart';
import '../../core/components/toast_message.dart';
import '../../core/constants/app_colors.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(),
          SliverToBoxAdapter(
            child: Obx(
              () {
                if (cartController.cartItems.isEmpty) {
                  return Container(
                    height: 200.h,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary.withOpacity(
                        0.2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Empty Cart!\nPlease add item in your cart to proceed.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: cartController.cartItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return SingleCartItemTile(
                      cartItem: cartController.cartItems[index],
                    );
                  },
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => Padding(
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
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: ElevatedButton(
                  onPressed: () {
                    if (cartController.cartItems.isEmpty) {
                      showToast("Your cart is empty");
                    } else {
                      Get.to(() => const CheckoutPage());
                    }
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
