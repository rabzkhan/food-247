import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/components/app_back_button.dart';
import '../../core/components/product_card_widget.dart';
import '../../core/constants/constants.dart';

class PopularPackPage extends StatelessWidget {
  const PopularPackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Packs'),
        leading: const AppBackButton(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            //   child: GridView.builder(
            //     padding: const EdgeInsets.only(top: AppDefaults.padding),
            //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //       maxCrossAxisExtent: 200,
            //       childAspectRatio: 0.73,
            //       crossAxisSpacing: 16,
            //       mainAxisSpacing: 16,
            //     ),
            //     itemCount: 8,
            //     itemBuilder: (context, index) {
            //       return ProductCardWidget(
            //         data: Dummy.bundles.first,
            //       );
            //     },
            //   ),
            // ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(AppDefaults.padding * 2),
                decoration: const BoxDecoration(
                  color: Colors.white60,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.shoppingBag),
                      const SizedBox(width: AppDefaults.padding),
                      const Text('Create Own Pack'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
