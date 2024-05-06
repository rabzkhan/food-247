import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/product_controller.dart';
import 'package:get/get.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/buy_now_row_button.dart';
import '../../core/components/network_image.dart';
import '../../core/components/price_and_quantity.dart';
import '../../core/components/product_images_slider.dart';
import '../../core/constants/api_urls.dart';
import '../../core/constants/constants.dart';
import '../../core/models/product_details_model.dart';
import '../../core/models/product_list_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
    required this.products,
  }) : super(key: key);

  final Products products;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    productController.getProductDetails(widget.products.productNameId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Product Details'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: BuyNowRow(
            onBuyButtonTap: () {},
            onCartButtonTap: () {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImagesSlider(
              images: [
                "${ApiUrls.baseUrl}/${widget.products.imagePath}",
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12).r,
              child: Text(
                widget.products.productName ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            /// Product Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Product Details',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.products.description ?? ''),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Size",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: 40.h,
                    child: Obx(() {
                      if (productController.isProductDetailsLoading.value) {
                        return const SizedBox();
                      }
                      if (productController.productSizes.isEmpty) {
                        return const SizedBox();
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController.productSizes.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProductSize productSize = productController.productSizes[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: index == 0 ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.white,
                              border: Border.all(
                                color: index == 0
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).primaryColor.withOpacity(0.1),
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                            ),
                            margin: const EdgeInsets.only(right: 15).r,
                            child: Center(
                              child: Text(
                                productSize.name ?? '',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Extra",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Obx(() {
                      if (productController.isProductDetailsLoading.value) {
                        return const SizedBox();
                      }
                      if (productController.productExtraItems.isEmpty) {
                        return const SizedBox();
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController.productExtraItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProductExtraItem extraItem = productController.productExtraItems[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: index == 0 ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.white,
                              border: Border.all(
                                color: index == 0
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).primaryColor.withOpacity(0.1),
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10).r,
                            margin: const EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: NetworkImageWithLoader(
                                      "${ApiUrls.baseUrl}/${extraItem.image}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                10.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      extraItem.name ?? '',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Text(
                                      '\$${extraItem.price}',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: PriceAndQuantityRow(
                currentPrice: double.parse(widget.products.price.toString()),
                orginalPrice: double.parse(widget.products.price.toString()),
                quantity: 2,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
