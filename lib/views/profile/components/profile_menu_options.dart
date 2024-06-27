import 'package:flutter/material.dart';
import 'package:food/core/components/local_db.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:food/views/auth/login_page.dart';
import 'package:food/views/parent/parent_page.dart';
import 'package:food/views/splash/splash_view.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import 'profile_list_tile.dart';

class ProfileMenuOptions extends GetView<ProfileController> {
  const ProfileMenuOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Column(
        children: [
          controller.isLoggedIn.value
              ? ProfileListTile(
                  title: 'Logout',
                  icon: AppIcons.profileLogout,
                  onTap: () {
                    Get.find<ProfileController>().userId.value = '';
                    Get.find<ProfileController>().isLoggedIn.value = false;
                    MySharedPref.clear();
                    Get.offAll(const SplashView());
                  },
                )
              : ProfileListTile(
                  title: 'Sign in',
                  icon: AppIcons.profileLogout,
                  onTap: () {
                    Get.find<ProfileController>().userId.value = '';
                    Get.to(const LoginPage());
                  },
                ),
        ],
      ),
    );
  }
}
