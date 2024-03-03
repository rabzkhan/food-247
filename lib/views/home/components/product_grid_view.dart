import 'package:flutter/material.dart';
import 'package:food/core/components/product_card_widget.dart';
import '../../../core/constants/constants.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.only(top: AppDefaults.padding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: Dummy.bundles.length,
        itemBuilder: (context, index) {
          return ProductCardWidget(data: Dummy.bundles[index]);
        },
      ),
    );
  }
}
