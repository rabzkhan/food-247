import 'package:flutter/material.dart';
import 'package:food/core/components/local_db.dart';
import 'package:food/views/auth/login_page.dart';
import 'package:food/views/profile/profile_page.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import '../profile_edit_page.dart';
import '../userinfo/user_info.dart';
import 'profile_list_tile.dart';

class ProfileMenuOptions extends StatelessWidget {
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
          ProfileListTile(
            title: 'My Profile',
            icon: AppIcons.profilePerson,
            onTap: () {
              Get.to(() => UserInfo());
            },
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Notification',
            icon: AppIcons.profileNotification,
            onTap: () {},
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Setting',
            icon: AppIcons.profileSetting,
            onTap: () {},
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Payment',
            icon: AppIcons.profilePayment,
            onTap: () {},
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Logout',
            icon: AppIcons.profileLogout,
            onTap: () async {
              MySharedPref.clear();
              Get.offAll(const LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
