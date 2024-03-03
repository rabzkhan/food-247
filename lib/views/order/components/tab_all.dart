import 'package:flutter/material.dart';
import 'package:food/core/constants/dummy_data.dart';
import 'package:get/get.dart';

import '../../../core/enums/dummy_order_status.dart';

import '../order_details.dart';
import 'order_details_product_tile.dart';
import 'order_preview_tile.dart';

class AllTab extends StatelessWidget {
  const AllTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.confirmed,
          onTap: () => {Get.to(() => OrderDetailsPage())},
        ),
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.processing,
          onTap: () => {},
        ),
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.shipped,
          onTap: () => {},
        ),
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.delivery,
          onTap: () => {},
        ),
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.cancelled,
          onTap: () => {},
        ),
      ],
    );
  }
}
