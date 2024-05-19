import 'package:flutter/material.dart';
import 'package:food/core/constants/constants.dart';
import 'package:food/core/controllers/checkout_controller.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../core/components/title_and_action_button.dart';

class ChooseOrderType extends GetView<CheckoutController> {
  const ChooseOrderType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButtonWidget(
          title: 'Choose Order Type',
          actionLabel: '',
          onTap: () {},
          isHeadline: false,
        ),
        Obx(() => ToggleSwitch(
              minWidth: Get.width,
              initialLabelIndex: controller.orderType.value,
              cornerRadius: 12.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey.withOpacity(0.2),
              inactiveFgColor: Colors.black54,
              totalSwitches: 2,
              labels: const ['Delivery', 'Takeaway'],
              activeBgColors: const [
                [AppColors.primary],
                [AppColors.primary]
              ],
              onToggle: (index) {
                controller.orderType.value = index!;
              },
            )),
      ],
    );
  }
}
