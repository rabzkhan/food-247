import 'package:flutter/material.dart';
import 'package:food/core/components/auth_alert.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import '../../order/my_order_page.dart';
import '../address/address_page.dart';
import 'profile_squre_tile.dart';

class ProfileHeaderOptions extends GetView<ProfileController> {
  const ProfileHeaderOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDefaults.borderRadius,
        boxShadow: AppDefaults.boxShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileSqureTile(
            label: 'Address',
            icon: AppIcons.homeProfile,
            onTap: () {
              !controller.isLoggedIn.value ? customAuthAlert().show() : Get.to(() => const AddressPage());
            },
          ),
          ProfileSqureTile(
            label: 'All Order',
            icon: AppIcons.truckIcon,
            onTap: () {
              !controller.isLoggedIn.value ? customAuthAlert().show() : Get.to(() => (const OrderPage()));
            },
          ),
        ],
      ),
    );
  }
}
