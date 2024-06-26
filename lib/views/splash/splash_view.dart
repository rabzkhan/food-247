import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/constants/app_icons.dart';
import 'package:get/get.dart';

import '../../core/components/local_db.dart';
import '../auth/login_page.dart';
import '../onboarding/onboarding_page.dart';
import '../parent/parent_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    late bool intoOnboard = MySharedPref.getOnboardingStatus() ?? true;
    late String intoAuth = MySharedPref.getToken() ?? '';
    late Widget initPage = const OnboardingPage();
    if (intoOnboard) {
      initPage = const OnboardingPage();
    } else if (intoAuth.isEmpty) {
      initPage = const LoginPage();
    } else {
      initPage = const ParentPage();
    }

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.to(() => initPage);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppIcons.logo,
          height: 300.h,
        ).animate().scale(duration: 1000.ms).fadeIn(),
      ),
    );
  }
}
