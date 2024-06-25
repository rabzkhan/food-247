import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/components/product_card_widget.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:get/get.dart';
import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';
import '../../core/models/categories_model.dart';
import '../home/components/floating_cart_button.dart';

class SingleMenuPage extends StatefulWidget {
  const SingleMenuPage({
    super.key,
    required this.category,
  });
  final Category category;

  @override
  State<SingleMenuPage> createState() => _SingleMenuPageState();
}

class _SingleMenuPageState extends State<SingleMenuPage> {
  HomeController homeController = Get.find();
  @override
  void initState() {
    homeController.getCategoriesWiseProducts(widget.category.productTypeId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingCartButton(),
      appBar: AppBar(
        title: Text(widget.category.productTypeName ?? ''),
        leading: const AppBackButton(),
      ),
      body: Obx(
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
              childAspectRatio: 1 / 1.3,
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
    );
  }
}
