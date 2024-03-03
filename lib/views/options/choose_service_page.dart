import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food/views/options/choose_delivery_options.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

class ChooseServicePage extends StatelessWidget {
  const ChooseServicePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please choose which service',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      'do you need',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 5),
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const ChooseDeliveryOptionPage());
                      },
                      child: const Text('Catering'),
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    ),
                  ),
                  const SizedBox(height: AppDefaults.padding),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => const ChooseDeliveryOptionPage());
                      },
                      child: Text('Order Food'),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(
                          side: BorderSide(
                            width: 4,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
