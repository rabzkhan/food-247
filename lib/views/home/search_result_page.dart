import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/components/product_card_widget.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        leading: const AppBackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Field',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: SvgPicture.asset(AppIcons.search),
                ),
                suffixIconConstraints: const BoxConstraints(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Text(
                '33 Products Found',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppDefaults.padding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                childAspectRatio: 1 / 1.4,
              ),
              itemCount: Dummy.bundles.length,
              itemBuilder: (context, index) {
                return ProductCardWidget(
                  data: Dummy.bundles[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
