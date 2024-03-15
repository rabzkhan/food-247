import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/views/menu/menu_page.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_cached_image.dart';
import '../../../core/constants/api_urls.dart';
import '../../../core/models/categories_model.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MenuPage(category: category));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
              borderRadius: BorderRadius.all(
                const Radius.circular(20).r,
              ),
            ),
            padding: const EdgeInsets.all(10).r,
            child: CustomImage(
              image: "${ApiUrls.baseUrl}/${category.image ?? ''}",
              height: 40.h,
              width: 40.w,
            ),
          ),
          Text(
            category.productTypeName ?? '',
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
