import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/controllers/checkout_controller.dart';
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
  CheckoutController checkoutController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const NewAddressPage());
        },
        backgroundColor: AppColors.primary,
        splashColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Delivery Address',
        ),
      ),
      body: Obx(() {
        if (profileController.isAddressListLoading.value) {
          return const SizedBox();
        }
        return ListView.builder(
          padding: EdgeInsets.zero.copyWith(top: 10.h),
          itemCount: profileController.addressList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6).r,
              child: InkWell(
                onTap: () {
                  checkoutController.selectedAddressIndex.value = index;
                  setState(() {});
                },
                child: AddressTile(
                  address: profileController.addressList[index],
                  index: index,
                  isActive: checkoutController.selectedAddressIndex.value == index ? true : false,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class AddressTile extends GetView<ProfileController> {
  const AddressTile({
    Key? key,
    required this.address,
    required this.index,
    required this.isActive,
  }) : super(key: key);

  final Address address;
  final int index;
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
                onPressed: () {
                  controller.deleteAddress(controller.addressList[index].id.toString());
                },
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
