import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/components/custom_cached_image.dart';
import 'package:food/core/constants/api_urls.dart';
import 'package:food/core/constants/app_icons.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:food/views/menu/single_menu_page.dart';
import 'package:get/get.dart';
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
              centerTitle: false,
              title: Image.asset(
                AppIcons.logo,
                height: 45.h,
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12).r,
                margin: const EdgeInsets.symmetric(horizontal: 12).r,
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
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: 230.h,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 12).r,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1 / 1,
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
          ],
        ),
      ),
    );
  }
}
