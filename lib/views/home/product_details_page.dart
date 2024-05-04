import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/buy_now_row_button.dart';
import '../../core/components/network_image.dart';
import '../../core/components/price_and_quantity.dart';
import '../../core/components/product_images_slider.dart';
import '../../core/constants/api_urls.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/constants.dart';
import '../../core/models/product_list_model.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    Key? key,
    required this.products,
  }) : super(key: key);

  final Products products;

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
                "${ApiUrls.baseUrl}/${products.imagePath}",
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12).r,
              child: Text(
                products.productName ?? '',
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
                  Text(products.description ?? ''),
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
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
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
                          margin: const EdgeInsets.only(right: 15),
                          child: Center(
                            child: Text(
                              "Large",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        );
                      },
                    ),
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
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
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10).r,
                          margin: EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: NetworkImageWithLoader(
                                    "${ApiUrls.baseUrl}/${products.imagePath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              10.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Extra Cheese",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    '\$${10}',
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
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: PriceAndQuantityRow(
                currentPrice: double.parse(products.price.toString()),
                orginalPrice: double.parse(products.price.toString()),
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
