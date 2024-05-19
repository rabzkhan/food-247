import 'package:flutter/material.dart';
import 'package:food/core/models/address_list_model.dart';

import '../../../core/components/app_radio.dart';
import '../../../core/constants/constants.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key,
    this.address,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final Address? address;
  final bool isActive;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Material(
        color: isActive ? AppColors.coloredBackground : AppColors.textInputBackground,
        borderRadius: AppDefaults.borderRadius,
        child: InkWell(
          borderRadius: AppDefaults.borderRadius,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              borderRadius: AppDefaults.borderRadius,
              border: Border.all(
                color: isActive ? AppColors.primary : Colors.grey,
                width: isActive ? 1 : 0.3,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRadio(isActive: isActive),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address?.address ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
