import 'package:flutter/material.dart';
import 'package:food/core/components/app_image_view.dart';
import 'package:food/core/components/custom_cached_image.dart';
import 'package:food/core/controllers/auth_controller.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:food/core/extension/shimmer_extension.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    controller.getIUerProfile();

    return Scaffold(
        appBar: AppBar(
          title: Text('User Info'),
        ),
        body: Scaffold(
          body: Column(
            children: [
              Obx(() {
                var data = controller.profileModel.value.data;

                if (controller.isLoading.value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppCustomImageView(
                              imagePath: data?.photo,
                              height: 120,
                              width: 120,
                              radius: BorderRadius.circular(100))
                          .shimmerEffect(),
                      listTileWithBottomDivider(
                              leading: "Name", trailing: "Unknown")
                          .shimmerEffect(),
                      listTileWithBottomDivider(
                              leading: "Email", trailing: "Unknown")
                          .shimmerEffect(),
                      listTileWithBottomDivider(
                              leading: "Phone", trailing: "Unknown")
                          .shimmerEffect(),
                      listTileWithBottomDivider(
                              leading: "Address", trailing: "Unknown")
                          .shimmerEffect(),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppCustomImageView(
                          imagePath: data?.photo,
                          height: 120,
                          width: 120,
                          radius: BorderRadius.circular(100)),
                      listTileWithBottomDivider(
                          leading: "Name", trailing: data?.fullName),
                      listTileWithBottomDivider(
                          leading: "Email", trailing: data?.email),
                      listTileWithBottomDivider(
                          leading: "Phone", trailing: data?.phone),
                      listTileWithBottomDivider(
                          leading: "Address", trailing: data?.address),
                    ],
                  );
                }
              }),
            ],
          ),
        ));
  }

  Widget listTileWithBottomDivider({String? leading, String? trailing}) {
    if (leading == null || trailing == null) return Container();

    return Column(
      children: [
        ListTile(
          leading: Text(leading ?? ""),
          trailing: Text(trailing ?? ""),
        ),
        Divider(),
      ],
    );
  }
}
