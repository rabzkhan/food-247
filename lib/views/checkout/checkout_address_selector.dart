import 'package:flutter/material.dart';
import 'package:food/core/constants/app_colors.dart';
import 'package:food/core/controllers/checkout_controller.dart';
import 'package:food/core/controllers/location_controller.dart';
import 'package:get/get.dart';

import '../../core/components/title_and_action_button.dart';
import '../../core/controllers/profile_controller.dart';
import 'checkout_address_card.dart';

class AddressSelector extends StatefulWidget {
  const AddressSelector({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  ProfileController profileController = Get.find();
  CheckoutController checkoutController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButtonWidget(
          title: 'Select Delivery Address',
          actionLabel: 'Add New',
          onTap: () {
            Get.put(LocationController());
            Get.find<LocationController>().getCurrentLocation();
          },
          isHeadline: false,
        ),
        Obx(() {
          if (profileController.isAddressListLoading.value) {
            return const SizedBox();
          }
          if (profileController.addressList.isEmpty) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary.withOpacity(
                  0.2,
                ),
              ),
              child: const Center(child: Text("Please add address\nbefore placing order.")),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: profileController.addressList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return AddressCard(
                address: profileController.addressList[index],
                isActive: checkoutController.selectedAddressIndex.value == index ? true : false,
                onTap: () {
                  checkoutController.selectedAddressIndex.value = index;
                  checkoutController.address.value = profileController.addressList[index].address ?? '';
                  checkoutController.latitude.value = profileController.addressList[index].latitude ?? '';
                  checkoutController.longitude.value = profileController.addressList[index].longitude ?? '';
                  setState(() {});
                },
              );
            },
          );
        })
      ],
    );
  }
}
