import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/models/product_list_model.dart';
import 'package:get/get.dart';
import '../../views/home/product_details_page.dart';
import '../constants/api_urls.dart';
import '../constants/constants.dart';
import '../models/dummy_bundle_model.dart';

import 'network_image.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  final Products products;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldBackground,
      borderRadius: AppDefaults.borderRadius,
      child: InkWell(
        onTap: () {
          Get.to(() => const ProductDetailsPage());
        },
        borderRadius: AppDefaults.borderRadius,
        child: Container(
          width: 176,
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: AppColors.placeholder),
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AspectRatio(
                  aspectRatio: 1 / 0.8,
                  child: NetworkImageWithLoader(
                    "${ApiUrls.baseUrl}/${products.imagePath}",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.productName ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '\$${products.price ?? ''}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '\$${products.price ?? ''}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    AppIcons.cardAdd,
                    height: 25,
                    width: 25,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
