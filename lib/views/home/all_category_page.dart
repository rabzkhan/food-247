import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../menu/single_menu_page.dart';
import 'widgets/category_card_widget.dart';

class AllCategoryPage extends GetView<HomeController> {
  const AllCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: false,
            title: Text(
              "All Category",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SliverFillRemaining(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12).r,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1 / 1,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => SingleMenuPage(category: controller.categories[index]));
                  },
                  child: CategoryCardWidget(
                    category: controller.categories[index],
                    isSelected: false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
