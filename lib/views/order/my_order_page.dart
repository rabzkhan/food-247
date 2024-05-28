import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import 'components/order_preview_tile.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Order',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: AppColors.cardColor,
        child: Obx(() {
          if (profileController.isOrderListLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (profileController.orderList.isEmpty) {
            return Center(
              child: InkWell(
                onTap: () {
                  profileController.getOrderList();
                },
                child: Image.asset(
                  AppImages.empty,
                  height: 200.h,
                  width: 200.w,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.only(top: 8),
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: profileController.orderList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return OrderPreviewTile(
                    order: profileController.orderList[index],
                  );
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
