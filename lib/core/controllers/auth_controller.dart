import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food/core/components/custom_snackbar.dart';
import 'package:food/core/constants/api_urls.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../views/parent/parent_page.dart';
import '../components/local_db.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class AuthController extends GetxController {
  RxBool isSignUpLoading = false.obs;
  RxBool isSignInLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    if (MySharedPref.getToken() != null) {
      isLoggedIn.value = true;
      Logger().d("Logged In");
    } else {
      isLoggedIn.value = false;
      Logger().d("Not Logged In");
    }

    super.onInit();
  }

  signUp(Map signUpData) async {
    await ApiClient.apiCall(
      ApiUrls.signUp,
      RequestType.post,
      headers: Header.defaultHeader,
      data: json.encode(signUpData),
      onLoading: () {
        isSignUpLoading.value = true;
      },
      onSuccess: (response) {
        Logger().d(response);
        var signInData = {
          "country_code": signUpData['country_code'],
          "phone": signUpData['phone'],
          "password": signUpData['password'],
        };
        signIn(signInData);
      },
      onError: (error) {
        Logger().d(error.message);
        isSignUpLoading.value = false;
      },
    );
  }

  signIn(Map signInData) async {
    await ApiClient.apiCall(
      ApiUrls.signIn,
      RequestType.post,
      headers: Header.defaultHeader,
      data: json.encode(signInData),
      onLoading: () {
        isSignUpLoading.value = true;
      },
      onSuccess: (response) {
        MySharedPref.setToken(response.data['token']);
        Logger().d(response.data['token']);
        Get.offAll(() => const ParentPage());
        Get.find<ProfileController>().getUserInfo();
        CustomSnackBar.showCustomSnackBar(
          title: "Success",
          message: "Signed in succeessfully",
        );
      },
      onError: (error) {
        CustomSnackBar.showCustomSnackBar(
          title: "Failed",
          message: "Invalid Credentials",
        );
        isSignUpLoading.value = false;
      },
    );
  }
}
