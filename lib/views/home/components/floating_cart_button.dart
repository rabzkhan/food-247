import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../core/controllers/cart_controller.dart';
import '../../cart/cart_page.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const CartPage());
      },
      child: SizedBox(
        height: 60.h,
        width: 70.w,
        child: Stack(
          children: [
            SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const CartPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: const CircleBorder(),
                ),
                child: SvgPicture.asset(
                  AppIcons.cart,
                  height: 30.h,
                ),
              ),
            ),
            Obx(
              () {
                if (Get.find<CartController>().cartItems.isEmpty) {
                  return const SizedBox();
                }
                return Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 25.h,
                    width: 25.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accent,
                    ),
                    child: Text(
                      Get.find<CartController>().cartItems.length.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
