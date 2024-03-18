import 'package:food/core/models/banner_model.dart';
import 'package:food/core/models/product_list_model.dart';
import 'package:get/get.dart';
import '../constants/api_urls.dart';
import '../models/categories_model.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class HomeController extends GetxController {
  //for banners
  RxBool isBannerLoading = false.obs;
  RxList<BannerData> banners = <BannerData>[].obs;

  //for categories
  RxBool isCategoriesLoading = false.obs;
  RxInt selectedCategoryIndex = 0.obs;
  RxList<Category> categories = <Category>[].obs;

  //for categories
  RxBool isProductsLoading = false.obs;
  Rx<ProductListData> productsList = ProductListData().obs;

  @override
  void onInit() {
    getBanner();
    getCategories();
    super.onInit();
  }

  getBanner() async {
    await ApiClient.apiCall(
      ApiUrls.banner,
      RequestType.get,
      headers: Header.defaultHeader,
      onLoading: () {
        isBannerLoading.value = true;
      },
      onSuccess: (response) {
        banners.value = BannerModel.fromJson(response.data).response!;
        isBannerLoading.value = false;
      },
      onError: (error) {
        isBannerLoading.value = false;
      },
    );
  }

  getCategories() async {
    await ApiClient.apiCall(
      ApiUrls.categories,
      RequestType.get,
      headers: Header.defaultHeader,
      onLoading: () {
        isCategoriesLoading.value = true;
      },
      onSuccess: (response) {
        categories.value = CategoriesModel.fromJson(response.data).data!;
        isCategoriesLoading.value = false;
      },
      onError: (error) {
        isCategoriesLoading.value = false;
      },
    );
  }

  getCategoriesWiseProducts(String categoryId) async {
    await ApiClient.apiCall(
      "${ApiUrls.categoryWiseProducts}$categoryId",
      RequestType.get,
      headers: Header.defaultHeader,
      onLoading: () {
        isProductsLoading.value = true;
      },
      onSuccess: (response) {
        productsList.value = ProductListModel.fromJson(response.data).data ?? ProductListData();
        isProductsLoading.value = false;
      },
      onError: (error) {
        isProductsLoading.value = false;
      },
    );
  }
}
