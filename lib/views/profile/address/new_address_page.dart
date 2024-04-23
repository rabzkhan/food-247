import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/components/app_back_button.dart';

class NewAddressPage extends StatelessWidget {
  const NewAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'New Address',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(AppDefaults.padding),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding * 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Address"),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDefaults.padding),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Save Adress'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
