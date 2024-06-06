import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:food/views/order/my_order_page.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/controllers/profile_controller.dart';
import '../home/home_page.dart';
import '../menu/menu_page.dart';
import '../profile/profile_page.dart';
import 'components/app_navigation_bar.dart';

/// This page will contain all the bottom navigation tabs
class ParentPage extends StatefulWidget {
  const ParentPage({Key? key}) : super(key: key);

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  ProfileController profileController = Get.find();

  /// Current Page
  int currentIndex = 0;

  @override
  void initState() {
    profileController.getUserInfo();
    super.initState();
  }

  /// On labelLarge navigation tap
  void onBottomNavigationTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  /// All the pages
  List<Widget> pages = [
    const HomePage(),
    const MenuPage(),
    const OrderPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.scaffoldBackground,
            child: child,
          );
        },
        duration: AppDefaults.duration,
        child: pages[currentIndex],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onNavTap: onBottomNavigationTap,
      ),
    );
  }
}
