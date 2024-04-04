import 'package:food/core/models/profile_model.dart';
import 'package:get/get.dart';

import '../constants/api_urls.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class ProfileController extends GetxController {
  var profileModel = ProfileModel().obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getIUerProfile();
  }

  getIUerProfile() async {
    await ApiClient.apiCall(
      ApiUrls.getMyProfile,
      RequestType.get,
      headers: Header.secureHeader(),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccess: (response) {
        profileModel.value = ProfileModel.fromJson(response.data);
        isLoading.value = false;
      },
      onError: (error) {
        isLoading.value = false;
      },
    );
  }
}
