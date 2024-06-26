import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food/core/constants/constants.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit fit;

  const CustomImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    this.radius = 2,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => Image.asset(
          AppIcons.placeholder,
          height: height,
          width: width,
          fit: fit,
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppIcons.placeholder,
          height: height,
          width: width,
          fit: fit,
        ),
      ),
    );
  }
}
