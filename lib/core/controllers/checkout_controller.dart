import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CheckoutController extends GetxController {
  RxBool isPlaceOrderLoading = false.obs;

  // 1 for delivery 0 for takeaway
  RxInt orderType = 0.obs;
  RxBool isCOD = true.obs;

  //address
  RxInt selectedAddressIndex = 0.obs;
  RxString address = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  //price
  RxDouble totalAmout = 0.0.obs;
  RxDouble paidAmount = 0.0.obs;
  RxBool isPaid = false.obs;
}
