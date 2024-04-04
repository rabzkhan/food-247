import 'package:flutter/material.dart';
import 'package:food/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

extension ShimmerExtension on Widget {
  Widget shimmerEffect() {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withOpacity(0.5),
      highlightColor: AppColors.gray.withOpacity(1),
      child: this,
    );
  }
}
