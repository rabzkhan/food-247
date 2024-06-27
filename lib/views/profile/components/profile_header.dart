import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:food/views/auth/login_page.dart';
import 'package:get/get.dart';
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
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(6).r,
              width: 80.w,
              height: 80.h,
              child: ClipOval(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset(
                    AppIcons.user,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDefaults.padding),
            !controller.isLoggedIn.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Guest User",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        "Please login to explore more",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                      ),
                    ],
                  )
                : Column(
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
