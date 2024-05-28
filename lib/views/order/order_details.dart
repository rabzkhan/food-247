// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:food/core/models/order_list_model.dart';
import 'package:food/views/order/components/ordered_item_widget.dart';
import '../../core/components/app_back_button.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    Key? key,
    this.order,
  });
  final Order? order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(AppDefaults.margin),
          padding: const EdgeInsets.all(AppDefaults.padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Id : ${order?.orderCode?.toString()}',
                  style:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: order!.orderDetails!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return OrderedItemWidget(
                    orderDetail: order!.orderDetails![index],
                  );
                },
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Amount',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '\$ ${order?.totalAmount?.toString()}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Order Type',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        order?.orderType?.toUpperCase() ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
