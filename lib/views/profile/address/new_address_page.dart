import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/location_controller.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/components/app_back_button.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({Key? key}) : super(key: key);

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  LocationController locationController = Get.find();
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
          Obx(() {
            if (locationController.address.value.isEmpty) {
              const GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(23.0225, 72.5714),
                  zoom: 12,
                ),
              );
            }
            return GoogleMap(
              onMapCreated: locationController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(locationController.latitude.value, locationController.longitude.value),
                zoom: 15,
              ),
              markers: Set<Marker>.of(locationController.markers),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            );
          }),
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
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                            child: Text("Address : ${locationController.address.value}"),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: const Text('Save Adress'),
                              onPressed: () {
                                var addressData = {
                                  "user_id": Get.find<ProfileController>().userId.value,
                                  "address": locationController.address.value,
                                  "latitude": locationController.latitude.value,
                                  "longitude": locationController.longitude.value,
                                };
                                locationController.addAddress(addressData);
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
