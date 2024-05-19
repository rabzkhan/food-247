import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:food/core/models/address_list_model.dart';
import 'package:get/get.dart';

import '../../../core/components/app_back_button.dart';
import '../../../core/components/app_radio.dart';
import '../../../core/constants/constants.dart';
import 'new_address_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Delivery Address',
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: AppDefaults.borderRadius,
        ),
        child: Stack(
          children: [
            Obx(() {
              if (profileController.isAddressListLoading.value) {
                return const SizedBox();
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: profileController.addressList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return AddressTile(
                    address: profileController.addressList[index],
                    isActive: index == 0,
                  );
                },
              );
            }),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  Get.to(() => const NewAddressPage());
                },
                backgroundColor: AppColors.primary,
                splashColor: AppColors.primary,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  const AddressTile({
    Key? key,
    required this.address,
    required this.isActive,
  }) : super(key: key);

  final Address address;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRadio(isActive: isActive),
          const SizedBox(width: AppDefaults.padding),
          Expanded(
            child: Text(
              address.address ?? '',
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.edit),
                constraints: const BoxConstraints(),
                iconSize: 14,
              ),
              const SizedBox(height: AppDefaults.margin / 2),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.deleteOutline),
                constraints: const BoxConstraints(),
                iconSize: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}
