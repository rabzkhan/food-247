import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../core/components/product_card_widget.dart';
import '../../core/constants/app_defaults.dart';
import 'components/floating_cart_button.dart';

class AllFeaturedProductsPage extends GetView<HomeController> {
  const AllFeaturedProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingCartButton(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            centerTitle: false,
            title: Text(
              "All Featured Products",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SliverFillRemaining(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppDefaults.padding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.r,
                crossAxisSpacing: 20.r,
                childAspectRatio: 1 / 1.1,
              ),
              itemCount: controller.featuredProducts.length,
              itemBuilder: (context, index) {
                return ProductCardWidget(
                  products: controller.featuredProducts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
