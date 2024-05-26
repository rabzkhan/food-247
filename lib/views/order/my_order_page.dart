import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/components/app_back_button.dart';
import '../../core/constants/app_colors.dart';
import 'components/custom_tab_label.dart';
import 'components/dummy_order_status.dart';
import 'components/order_preview_tile.dart';
import 'order_details.dart';

class AllOrderPage extends StatelessWidget {
  const AllOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Order',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: AppColors.cardColor,
          child: ListView(
            padding: const EdgeInsets.only(top: 8),
            children: [
              OrderPreviewTile(
                orderID: '232425627',
                date: '25 Nov',
                status: OrderStatus.confirmed,
                onTap: () => {
                  // Get.to(
                  //   () => OrderDetailsPage(),
                  // ),
                },
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
          ),
        ),
      ),
    );
  }
}
