import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      body: Stack(
        children: [
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(23.0225, 72.5714),
              zoom: 12,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: AppDefaults.borderRadius,
                ),
                padding: const EdgeInsets.all(8).r,
                child: SizedBox(
                  height: 130.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                        child: Text("Address goes here"),
                      ),
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
            ),
          ),
        ],
      ),
    );
  }
}
