import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/constants/app_icons.dart';
import 'package:get/get.dart';
import '../../core/components/product_card_widget.dart';
import '../../core/components/network_image.dart';
import '../../core/components/title_and_action_button.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/dummy_data.dart';
import '../menu/menu_page.dart';
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
                      Get.to(() => const MenuPage());
                    },
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
