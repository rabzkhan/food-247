import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/components/custom_cached_image.dart';
import 'package:food/core/constants/api_urls.dart';
import 'package:food/core/constants/app_icons.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:food/core/models/categories_model.dart';
import 'package:get/get.dart';
import '../../core/components/product_card_widget.dart';
import '../../core/components/title_and_action_button.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/dummy_data.dart';
import '../menu/menu_page.dart';
import 'search_page.dart';
import 'widgets/category_card_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Image.asset(
                AppIcons.logo,
                height: 32,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2F6F3),
                      shape: const CircleBorder(),
                    ),
                    child: SvgPicture.asset(AppIcons.sidebarIcon),
                  ),
                ),
              ],
            ),
            //SearchBar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                  vertical: AppDefaults.padding,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const SearchPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: const CircleBorder(),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "Search food...",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Obx(
                    () => SizedBox(
                      height: 220.h,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10.r,
                          crossAxisSpacing: 10.r,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCardWidget(category: controller.categories[index]);
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
          ],
        ),
      ),
    );
  }
}
