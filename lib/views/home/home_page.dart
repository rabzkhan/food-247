import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/constants/app_icons.dart';
import 'package:get/get.dart';
import '../../core/components/product_card_widget.dart';
import '../../core/components/network_image.dart';
import '../../core/components/title_and_action_button.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/dummy_data.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: SvgPicture.asset(
                "assets/images/app_logo.svg",
                height: 32,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const SearchPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2F6F3),
                      shape: const CircleBorder(),
                    ),
                    child: SvgPicture.asset(AppIcons.search),
                  ),
                ),
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
            //Banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: NetworkImageWithLoader(
                      'https://i.imgur.com/8hBIsS5.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TitleAndActionButtonWidget(
                      title: 'Popular Items',
                      onTap: () {
                        // Get.to(()=> VieAll());
                      }),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: AppDefaults.padding),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        Dummy.bundles.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: AppDefaults.padding),
                          child: ProductCardWidget(data: Dummy.bundles[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TitleAndActionButtonWidget(
                    title: 'New Items',
                    onTap: () => {},
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: AppDefaults.padding),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        Dummy.bundles.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: AppDefaults.padding),
                          child: ProductCardWidget(data: Dummy.bundles[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
