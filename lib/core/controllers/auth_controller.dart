import 'dart:convert';

import 'package:food/core/components/custom_snackbar.dart';
import 'package:food/core/consts/api_urls.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../views/parent/parent_page.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class AuthController extends GetxController {
  RxBool isSignUpLoading = false.obs;
  RxBool isSignInLoading = false.obs;

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
        var signInData = {
          "country_code": signUpData['country_code'],
          "phone": signUpData['phone'],
          "password": signUpData['password'],
        };
        signIn(signInData);
      },
      onError: (error) {
        Logger().d(error);
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
        Get.offAll(() => const ParentPage());
        CustomSnackBar.showCustomSnackBar(
          title: "Success",
          message: "Signed in succeessfully",
        );
      },
      onError: (error) {
        Logger().d(error);
        isSignUpLoading.value = false;
      },
    );
  }
}
