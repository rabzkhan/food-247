import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/constants/constants.dart';
import 'package:food/core/controllers/auth_controller.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'components/order_preview_tile.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  ProfileController profileController = Get.find();
  AuthController authController = Get.find();
  @override
  void initState() {
    if (profileController.isLoggedIn.value) {
      profileController.getOrderList();
    } else {}
    super.initState();
  }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppIcons.empty,
                      height: 200.h,
                      width: 200.w,
                    ),
                    20.verticalSpace,
                    Text(
                      "You didn't make any order yet!",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
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
