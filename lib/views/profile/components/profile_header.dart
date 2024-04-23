import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';
import 'profile_header_options.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        Image.asset('assets/images/profile_page_background.png'),

        /// Content
        Column(
          children: [
            AppBar(
              title: const Text('Profile'),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const UserData(),
            const ProfileHeaderOptions()
          ],
        ),
      ],
    );
  }
}

class UserData extends GetView<ProfileController> {
  const UserData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Row(
          children: [
            const SizedBox(width: AppDefaults.padding),
            const SizedBox(
              width: 100,
              height: 100,
              child: ClipOval(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                      'https://static.vecteezy.com/system/resources/thumbnails/002/318/271/small_2x/user-profile-icon-free-vector.jpg'),
                ),
              ),
            ),
            const SizedBox(width: AppDefaults.padding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.profileData.value.countryCode ?? ''} ${controller.profileData.value.phone ?? ''}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email : ${controller.profileData.value.email ?? ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
