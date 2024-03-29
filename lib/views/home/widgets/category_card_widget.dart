import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/components/custom_cached_image.dart';
import '../../../core/constants/api_urls.dart';
import '../../../core/models/categories_model.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.category,
    required this.isSelected,
  });

  final Category category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).hoverColor,
            borderRadius: BorderRadius.all(
              const Radius.circular(20).r,
            ),
          ),
          padding: const EdgeInsets.all(10).r,
          child: CustomImage(
            image: "${ApiUrls.baseUrl}/${category.image ?? ''}",
            height: 45.h,
            width: 45.w,
          ),
        ),
        Text(
          category.productTypeName ?? '',
          maxLines: 2,
          style: TextStyle(
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
