import 'package:food/core/models/banner_model.dart';
import 'package:food/core/models/hot_product_model.dart';
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

  //for popular products
  RxBool isPopularProductsLoading = false.obs;
  RxList<Products> popularProducts = <Products>[].obs;

  //for featured products
  RxBool isFeaturedProductsLoading = false.obs;
  RxList<Products> featuredProducts = <Products>[].obs;

  @override
  void onInit() {
    getBanner();
    getCategories();
    getPopularProducts();
    getFeaturedProducts();

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

  getPopularProducts() async {
    await ApiClient.apiCall(
      ApiUrls.popularProducts,
      RequestType.get,
      headers: Header.defaultHeader,
      onLoading: () {
        isPopularProductsLoading.value = true;
      },
      onSuccess: (response) {
        popularProducts.value = HotProductsModel.fromJson(response.data).data!;
        isPopularProductsLoading.value = false;
      },
      onError: (error) {
        isPopularProductsLoading.value = false;
      },
    );
  }

  getFeaturedProducts() async {
    await ApiClient.apiCall(
      ApiUrls.featuredProducts,
      RequestType.get,
      headers: Header.defaultHeader,
      onLoading: () {
        isFeaturedProductsLoading.value = true;
      },
      onSuccess: (response) {
        featuredProducts.value = HotProductsModel.fromJson(response.data).data!;
        isFeaturedProductsLoading.value = false;
      },
      onError: (error) {
        isFeaturedProductsLoading.value = false;
      },
    );
  }
}
