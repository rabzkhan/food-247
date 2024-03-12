import 'package:food/core/models/banner_model.dart';
import 'package:get/get.dart';
import '../constants/api_urls.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class HomeController extends GetxController {
  //for banners
  RxBool isBannerLoading = false.obs;
  RxList<BannerData> banners = <BannerData>[].obs;

  @override
  void onInit() {
    getBanner();
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
}
