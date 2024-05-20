import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/checkout_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/components/app_back_button.dart';
import '../../core/components/custom_snackbar.dart';
import '../../core/constants/app_defaults.dart';

import 'choose_order_type.dart';
import 'checkout_address_selector.dart';
import 'checkout_payment_systems.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Obx(() => Column(
              children: [
                ChooseOrderType(),
                10.verticalSpace,
                if (controller.orderType.value == 0) AddressSelector(),
                PaymentSystem(),
                PayNowButton(),
              ],
            )),
      ),
    );
  }
}

class PayNowButton extends GetView<CheckoutController> {
  const PayNowButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: ElevatedButton(
          onPressed: () {
            if (controller.orderType.value == 0) {
              if (controller.selectedAddressIndex.value == 100) {
                CustomSnackBar.showCustomSnackBar(
                  title: "Please",
                  message: "Choose an address!",
                );
              } else {
                controller.placeOrder();
              }
            } else {
              controller.placeOrder();
            }
          },
          child: const Text('Order Now'),
        ),
      ),
    );
  }
}
