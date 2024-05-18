import 'package:flutter/material.dart';
import 'package:food/core/controllers/location_controller.dart';
import 'package:get/get.dart';

import '../../../core/components/title_and_action_button.dart';
import '../../profile/address/address_page.dart';
import 'checkout_address_card.dart';

class AddressSelector extends StatelessWidget {
  const AddressSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButtonWidget(
          title: 'Select Delivery Address',
          actionLabel: 'Add New',
          onTap: () {
            Get.put(LocationController());
            Get.to(() => const AddressPage());
          },
          isHeadline: false,
        ),
        AddressCard(
          label: 'Home Address',
          phoneNumber: '(309) 071-9396-939',
          address: '1749 Custom Road, Chhatak',
          isActive: false,
          onTap: () {},
        ),
        AddressCard(
          label: 'Office Address',
          phoneNumber: '(309) 071-9396-939',
          address: '1749 Custom Road, Chhatak',
          isActive: true,
          onTap: () {},
        )
      ],
    );
  }
}
