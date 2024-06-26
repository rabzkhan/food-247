import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food/core/components/custom_snackbar.dart';
import 'package:food/core/constants/api_urls.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../views/parent/parent_page.dart';
import '../components/local_db.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find<AuthController>();
  String? token;

  RxBool isSignUpLoading = false.obs;
  RxBool isSignInLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthController(String? intoAuth) {
    token = intoAuth;
  }

  signUp(Map<String, String> signUpData) async {
    await ApiClient.apiCall(
      ApiUrls.signUp,
      RequestType.post,
      headers: Header.defaultHeader,
      data: json.encode(signUpData),
      onLoading: () {
        isSignUpLoading.value = true;
      },
      onSuccess: (response) {
        Map<String, String> signInData = {
          "country_code": signUpData['country_code'] ?? "",
          "phone": signUpData['phone'] ?? "",
          "password": signUpData['password'] ?? "",
        };
        signIn(signInData);
      },
      onError: (error) {
        //Logger().d(error.toString());
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

        token = response.data['token'];

        Get.offAll(() => const ParentPage());
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
