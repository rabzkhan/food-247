import 'package:flutter/material.dart';
import 'package:food/core/components/local_db.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:food/views/auth/login_page.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
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
          // ProfileListTile(
          //   title: 'My Profile',
          //   icon: AppIcons.profilePerson,
          //   onTap: () {},
          // ),
          // const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Logout',
            icon: AppIcons.profileLogout,
            onTap: () {
              Get.find<ProfileController>().userId.value = '';
              MySharedPref.clear();
              Get.offAll(const LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
