import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../core/components/product_card_widget.dart';
import '../../core/constants/constants.dart';
import '../home/components/floating_cart_button.dart';
import '../home/widgets/category_card_widget.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  HomeController homeController = Get.find();
  @override
  void initState() {
    homeController.selectedCategoryIndex.value = 0;
    homeController.getCategoriesWiseProducts(
      homeController.categories.first.productTypeId ?? '',
    );
    super.initState();
  }

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
              "Menu",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => SizedBox(
                height: 120.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.r).copyWith(left: 12).r,
                  itemCount: homeController.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      child: GestureDetector(
                        onTap: () {
                          homeController.selectedCategoryIndex.value = index;
                          homeController.getCategoriesWiseProducts(
                            homeController.categories[index].productTypeId ?? '',
                          );
                        },
                        child: CategoryCardWidget(
                          category: homeController.categories[index],
                          isSelected: index == homeController.selectedCategoryIndex.value ? true : false,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Obx(
              () {
                if (homeController.isProductsLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (homeController.productsList.value.productNames!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No products found",
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.r,
                    crossAxisSpacing: 20.r,
                    childAspectRatio: 1 / 1.1,
                  ),
                  itemCount: homeController.productsList.value.productNames!.length,
                  itemBuilder: (context, index) {
                    return ProductCardWidget(
                      products: homeController.productsList.value.productNames![index],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
