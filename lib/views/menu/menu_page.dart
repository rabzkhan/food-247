import 'package:flutter/material.dart';
import 'package:food/core/components/product_card_widget.dart';
import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        leading: const AppBackButton(),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppDefaults.padding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 1.4,
        ),
        itemCount: Dummy.bundles.length,
        itemBuilder: (context, index) {
          return ProductCardWidget(data: Dummy.bundles[index]);
        },
      ),
    );
  }
}
