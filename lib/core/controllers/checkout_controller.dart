import 'dart:convert';

import 'package:food/core/controllers/cart_controller.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../views/home/order_successfull_page.dart';
import '../components/custom_snackbar.dart';
import '../components/local_db.dart';
import '../constants/api_urls.dart';
import '../network/api_client.dart';

class CheckoutController extends GetxController {
  CartController cartController = Get.find();
  ProfileController profileController = Get.find();
  RxBool isPlaceOrderLoading = false.obs;

  // 1 for delivery 0 for takeaway
  RxInt orderType = 0.obs;
  RxBool isCOD = true.obs;

  //address
  RxInt selectedAddressIndex = 100.obs;
  RxString address = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  //price
  RxDouble totalAmout = 0.0.obs;
  RxDouble paidAmount = 0.0.obs;
  RxBool isPaid = false.obs;

  placeOrder() async {
    Map<String, dynamic> order = {
      "service_provider_id": 1,
      "customer_id": profileController.userId.value,
      "customer_email": profileController.profileData.value.email,
      "phone_no": profileController.profileData.value.countryCode.toString() +
          profileController.profileData.value.phone.toString(),
      "total_amount": cartController.totalPrice.value,
      "address": orderType.value == 0 ? address.value : '',
      "lat_value": orderType.value == 0 ? latitude.value : '',
      "long_value": orderType.value == 0 ? longitude.value : '',
      "order_type": orderType.value == 0 ? "delivery" : "takeaway",
      "order_details": cartController.cartItems.toList()
    };

    await ApiClient.apiCall(
      ApiUrls.placeOrder,
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${MySharedPref.getToken()}",
      },
      data: json.encode(
        order,
      ),
      onLoading: () {
        isPlaceOrderLoading.value = true;
      },
      onSuccess: (response) {
        Logger().d(response);
        isPlaceOrderLoading.value = false;

        Get.off(() => const OrderSuccessfullPage());
        profileController.getOrderList();
        cartController.clearCart();
      },
      onError: (error) {
        isPlaceOrderLoading.value = false;
        profileController.getOrderList();
        CustomSnackBar.showCustomSnackBar(
          title: "Failed",
          message: "Something Wrong",
        );
      },
    );
  }
}
