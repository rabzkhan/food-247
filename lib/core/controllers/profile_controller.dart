import 'dart:convert';

import 'package:food/core/controllers/auth_controller.dart';
import 'package:food/core/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../constants/api_urls.dart';
import '../models/address_list_model.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class ProfileController extends GetxController {
  AuthController authController = Get.find();

  RxBool isProfileLoading = false.obs;
  Rx<ProfileData> profileData = ProfileData().obs;

  RxBool isAddressListLoading = false.obs;
  RxList<Address> addressList = <Address>[].obs;

  @override
  void onInit() {
    if (authController.isLoggedIn.value) {
      getUserInfo();
    }

    super.onInit();
  }

  getUserInfo() async {
    await ApiClient.apiCall(
      ApiUrls.profileInfo,
      RequestType.get,
      headers: Header.secureHeader,
      onLoading: () {
        isProfileLoading.value = true;
      },
      onSuccess: (response) {
        Logger().d(response);
        profileData.value = ProfileModel.fromJson(response.data).data!;
        getAddressList();
        isProfileLoading.value = false;
      },
      onError: (error) {
        isProfileLoading.value = false;
      },
    );
  }

  getAddressList() async {
    var userId = {
      "user_id": Get.find<ProfileController>().profileData.value.customerId,
    };
    Logger().d(json.encode(userId));
    await ApiClient.apiCall(
      ApiUrls.getAddress,
      RequestType.get,
      headers: Header.secureHeader,
      data: json.encode(userId),
      onLoading: () {
        isAddressListLoading.value = true;
      },
      onSuccess: (response) {
        Logger().d(response);
        isAddressListLoading.value = false;
        addressList.value = AddressListModel.fromJson(response.data).data!;
      },
      onError: (error) {
        Logger().d(error);
        isAddressListLoading.value = false;
      },
    );
  }
}
