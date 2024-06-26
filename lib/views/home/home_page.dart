import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/components/custom_cached_image.dart';
import 'package:food/core/constants/api_urls.dart';
import 'package:food/core/constants/constants.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:food/views/home/all_category_page.dart';
import 'package:food/views/home/all_popular_products_page.dart';
import 'package:food/views/menu/single_menu_page.dart';
import 'package:get/get.dart';
import '../../core/components/product_card_widget.dart';
import '../../core/components/toast_message.dart';
import '../../core/controllers/cart_controller.dart';
import '../cart/cart_page.dart';
import 'all_featured_products_page.dart';
import 'components/floating_cart_button.dart';
import 'widgets/category_card_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingCartButton(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leadingWidth: 200.w,
              centerTitle: false,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "FOOD 24/7",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    if (Get.find<CartController>().cartItems.isNotEmpty) {
                      Get.to(() => const CartPage());
                    } else {
                      showToast("Your cart is empty");
                    }
                  },
                  child: SizedBox(
                    height: 60.h,
                    width: 70.w,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: Image.asset(
                            AppIcons.appBarCart,
                            scale: 3.2,
                          ),
                        ),
                        Obx(
                          () {
                            if (Get.find<CartController>().cartItems.isEmpty) {
                              return const SizedBox();
                            }
                            return Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20.h, top: 5.h),
                                child: Container(
                                  height: 25.h,
                                  width: 25.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                  ),
                                  child: Text(
                                    Get.find<CartController>().cartItems.length.toString(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            //SearchBar

            // SliverToBoxAdapter(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: const BorderRadius.all(Radius.circular(30)),
            //       border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
            //     ),
            //     padding: const EdgeInsets.symmetric(horizontal: 12).r,
            //     margin: const EdgeInsets.symmetric(horizontal: 12).r,
            //     child: Row(
            //       children: [
            //         ElevatedButton(
            //           onPressed: () {
            //             Get.to(() => const SearchPage());
            //           },
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.transparent,
            //             shape: const CircleBorder(),
            //           ),
            //           child: SvgPicture.asset(
            //             AppIcons.search,
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //         Text(
            //           "Search food...",
            //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 12).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Cuisines",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.black54,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Spacer(),
                        const Text(
                          "View All",
                          style: TextStyle(),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(() => const AllCategoryPage());
                          },
                          icon: Image.asset(
                            AppIcons.viewAll,
                            height: 20.h,
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: 280.h,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 12).r,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 1.1,
                        ),
                        itemCount: controller.categories.take(8).length,
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
                  )
                ],
              ),
            ),
            //Banner
            SliverToBoxAdapter(
              child: Obx(
                () => CarouselSlider(
                  options: CarouselOptions(
                    height: 200.h,
                    initialPage: 0,
                    viewportFraction: 0.85,
                    enlargeFactor: 0.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: controller.banners.map((data) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0).r,
                          child: CustomImage(
                            image: "${ApiUrls.baseUrl}/${data.image}",
                            height: 200.h,
                            width: double.infinity,
                            radius: 12.r,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            //Popular Products
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.isFeaturedProductsLoading.value) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Featured Products",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "View All",
                                style: TextStyle(),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.to(() => const AllFeaturedProductsPage());
                                },
                                icon: Image.asset(
                                  AppIcons.viewAll,
                                  height: 20.h,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.r,
                          crossAxisSpacing: 20.r,
                          childAspectRatio: 1 / 1.3,
                        ),
                        itemCount: controller.featuredProducts.take(4).length,
                        itemBuilder: (context, index) {
                          return ProductCardWidget(
                            products: controller.featuredProducts[index],
                          );
                        },
                      )
                    ],
                  ),
                );
              }),
            )

            //Popular Products
            ,
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.isFeaturedProductsLoading.value) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Popular Products",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "View All",
                                style: TextStyle(
                                    // color: Colors.green,
                                    ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.to(() => const AllPopularProductsPage());
                                },
                                icon: Image.asset(
                                  AppIcons.viewAll,
                                  height: 20.h,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.r,
                          crossAxisSpacing: 20.r,
                          childAspectRatio: 1 / 1.3,
                        ),
                        itemCount: controller.popularProducts.take(4).length,
                        itemBuilder: (context, index) {
                          return ProductCardWidget(
                            products: controller.popularProducts[index],
                          );
                        },
                      )
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
