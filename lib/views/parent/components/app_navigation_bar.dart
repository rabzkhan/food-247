import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import 'bottom_app_bar_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onNavTap,
  }) : super(key: key);

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: AppColors.scaffoldBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomAppBarItem(
            name: 'Home',
            iconLocation: AppIcons.home,
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
          ),
          BottomAppBarItem(
            name: 'Menu',
            iconLocation: AppIcons.menu,
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
          ),
          BottomAppBarItem(
            name: 'Orders',
            iconLocation: AppIcons.save,
            isActive: currentIndex == 2,
            onTap: () => onNavTap(2),
          ),
          BottomAppBarItem(
            name: 'Profile',
            iconLocation: AppIcons.profile,
            isActive: currentIndex == 3,
            onTap: () => onNavTap(3),
          ),
        ],
      ),
    );
  }
}
