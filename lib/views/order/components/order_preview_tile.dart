import 'package:flutter/material.dart';
import 'package:food/core/models/order_list_model.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import '../order_details.dart';

class OrderPreviewTile extends StatelessWidget {
  const OrderPreviewTile({
    this.order,
    Key? key,
  }) : super(key: key);
  final Order? order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: AppDefaults.borderRadius,
        child: InkWell(
          onTap: () {
            Get.to(() => OrderDetailsPage(order: order));
          },
          borderRadius: AppDefaults.borderRadius,
          child: Container(
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Order ID:'),
                    const SizedBox(width: 5),
                    Text(
                      order?.orderCode ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    Text("\$ ${order?.totalAmount}"),
                  ],
                ),
                Row(
                  children: [
                    Text("Order Type : ${order?.orderType?.toUpperCase() ?? ''}"),
                  ],
                ),
                Row(
                  children: [
                    Text("Order Status : ${order?.orderStatus?.toUpperCase() ?? ''}"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
