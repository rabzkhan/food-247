import 'package:food/core/models/banner_model.dart';
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
  RxList<Category> categories = <Category>[].obs;

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
        isBannerLoading.value = true;
      },
      onSuccess: (response) {
        categories.value = CategoriesModel.fromJson(response.data).data!;
        isBannerLoading.value = false;
      },
      onError: (error) {
        isBannerLoading.value = false;
      },
    );
  }
}
