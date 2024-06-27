import 'dart:convert';

import 'package:food/core/controllers/auth_controller.dart';
import 'package:food/core/models/order_list_model.dart';
import 'package:food/core/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../components/custom_snackbar.dart';
import '../components/local_db.dart';
import '../constants/api_urls.dart';
import '../models/address_list_model.dart';
import '../network/api_client.dart';

class ProfileController extends GetxController {
  AuthController authController = Get.find();
  RxBool isLoggedIn = false.obs;
  RxBool isProfileLoading = false.obs;
  Rx<ProfileData> profileData = ProfileData().obs;
  RxString userId = ''.obs;
  RxBool isAddressListLoading = false.obs;
  RxList<Address> addressList = <Address>[].obs;

  RxBool isOrderListLoading = false.obs;
  RxList<Order> orderList = <Order>[].obs;

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  getUserInfo() async {
    await ApiClient.apiCall(
      ApiUrls.profileInfo,
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${MySharedPref.getToken()}",
      },
      onLoading: () {
        isProfileLoading.value = true;
      },
      onSuccess: (response) {
        Logger().d(response);
        profileData.value = ProfileModel.fromJson(response.data).data!;
        userId.value = ProfileModel.fromJson(response.data).userId.toString();
        getAddressList();
        isLoggedIn.value = true;
        isProfileLoading.value = false;
      },
      onError: (error) {
        isProfileLoading.value = false;
      },
    );
  }

  getAddressList() async {
    var userId = {
      "user_id": Get.find<ProfileController>().userId.value,
    };
    await ApiClient.apiCall(
      ApiUrls.getAddress,
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${MySharedPref.getToken()}",
      },
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

  deleteAddress(String addressId) async {
    await ApiClient.apiCall(
      ApiUrls.deleteAddress + addressId,
      RequestType.delete,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${MySharedPref.getToken()}",
      },
      onLoading: () {},
      onSuccess: (response) {
        CustomSnackBar.showCustomSnackBar(
          title: "Success",
          message: "Address deleted!",
        );
        getAddressList();
      },
      onError: (error) {
        Logger().d(error);
      },
    );
  }

  getOrderList() async {
    var userId = {
      "user_id": Get.find<ProfileController>().userId.value,
    };
    await ApiClient.apiCall(
      ApiUrls.getOrderList,
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${MySharedPref.getToken()}",
      },
      data: json.encode(userId),
      onLoading: () {
        isOrderListLoading.value = true;
      },
      onSuccess: (response) {
        Logger().d(response);
        isOrderListLoading.value = false;
        orderList.value = OrderListModel.fromJson(response.data).orders ?? [];
      },
      onError: (error) {
        isOrderListLoading.value = false;
      },
    );
  }
}
