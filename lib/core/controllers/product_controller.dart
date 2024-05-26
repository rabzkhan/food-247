import 'dart:convert';

import 'package:food/core/models/product_details_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../constants/api_urls.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class ProductController extends GetxController {
  RxBool isProductDetailsLoading = false.obs;

  Rx<ProductDetails> productDetails = ProductDetails().obs;
  RxList<ProductExtraItem> productExtraItems = <ProductExtraItem>[].obs;
  RxList<ProductSize> productSizes = <ProductSize>[].obs;

  getProductDetails(String productId) async {
    productExtraItems.clear();
    productSizes.clear();
    await ApiClient.apiCall(
      ApiUrls.productDetails,
      RequestType.post,
      headers: Header.defaultHeader,
      data: json.encode({
        "product_name_id": productId,
      }),
      onLoading: () {
        isProductDetailsLoading.value = true;
      },
      onSuccess: (response) {
        productDetails.value = ProductDetailsModel.fromJson(response.data).data!.first;
        productExtraItems.addAll(productDetails.value.productExtraItem!);
        productSizes.addAll(productDetails.value.productSize!);
        isProductDetailsLoading.value = false;
      },
      onError: (error) {
        isProductDetailsLoading.value = false;
      },
    );
  }
}
