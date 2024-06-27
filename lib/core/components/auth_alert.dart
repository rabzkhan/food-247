import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/constants/app_colors.dart';
import 'package:food/core/constants/app_icons.dart';
import 'package:food/views/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert customAuthAlert() {
  return Alert(
    style: const AlertStyle(
      backgroundColor: Colors.white,
      animationType: AnimationType.grow,
      isOverlayTapDismiss: true,
      animationDuration: Duration(milliseconds: 400),
      alertAlignment: Alignment.center,
    ),
    context: Get.context!,
    type: AlertType.none,
    buttons: [],
    content: Column(
      children: [
        Image.asset(
          AppIcons.loginAlert,
          height: 120.h,
        ),
        20.verticalSpace,
        Text(
          "Please Sign In",
          style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        10.verticalSpace,
        Text(
          "To use this feature, you need to \nsign in.",
          textAlign: TextAlign.center,
          style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        20.verticalSpace,
        SizedBox(
          width: 120.w,
          child: ElevatedButton(
            onPressed: () {
              Get.back();
              Get.to(() => const LoginPage());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Set the desired border radius
                side: const BorderSide(
                  color: AppColors.primary,
                  width: 1.0,
                ), // Set the border color and width
              ),
            ),
            child: Text(
              "Sign In",
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        )
      ],
    ),
  );
}
