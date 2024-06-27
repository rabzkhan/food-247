import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/components/network_image.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/app_icons.dart';
import '../parent/parent_page.dart';

class OrderSuccessfullPage extends StatelessWidget {
  const OrderSuccessfullPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset(
                  AppIcons.orderPlaced,
                  height: 200.h,
                  width: 200.w,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              children: [
                Text(
                  'Order Placed Successfully',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                  child: Text(
                    'Thanks for your order. Your order has placed successfully. Please continue your order.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const ParentPage());
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: AppDefaults.padding,
                //   ),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: TextButton(
                //       onPressed: () {},
                //       child: const Text('Track Order'),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
