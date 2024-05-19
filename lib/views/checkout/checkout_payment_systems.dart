import 'package:flutter/material.dart';
import 'package:food/core/controllers/checkout_controller.dart';
import 'package:get/get.dart';

import '../../core/constants/constants.dart';
import 'checkout_payment_card_tile.dart';

class PaymentSystem extends GetView<CheckoutController> {
  const PaymentSystem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding / 2,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Payment System',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              PaymentCardTile(
                label: 'Cash On Delivery',
                icon: AppIcons.cashOnDelivery,
                onTap: () {
                  controller.isCOD.value = true;
                },
                isActive: controller.isCOD.value ? true : false,
              ),
            ],
          ),
        )
      ],
    );
  }
}
