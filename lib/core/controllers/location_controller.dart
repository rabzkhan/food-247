import 'dart:convert';

import 'package:food/core/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../components/custom_snackbar.dart';
import '../constants/api_urls.dart';
import '../network/api_client.dart';
import '../network/api_header.dart';

class LocationController extends GetxController {
  RxBool isAddressLoading = false.obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = ''.obs;
  var markers = <Marker>[].obs;
  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    updateMarker();
    getAddressFromLatLng(latitude.value, longitude.value);
  }

  Future<void> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address.value = "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
    } catch (e) {
      address.value = "Error: ${e.toString()}";
    }
  }

  void updateMarker() {
    final marker = Marker(
      markerId: const MarkerId('currentLocation'),
      position: LatLng(latitude.value, longitude.value),
      infoWindow: InfoWindow(title: 'Current Location', snippet: address.value),
    );
    markers.assignAll([marker]);
    mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(latitude.value, longitude.value)));
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    updateMarker();
  }

  addAddress(Map addressData) async {
    await ApiClient.apiCall(
      ApiUrls.addAddress,
      RequestType.post,
      headers: Header.secureHeader,
      data: json.encode(
        addressData,
      ),
      onLoading: () {
        isAddressLoading.value = true;
      },
      onSuccess: (response) {
        Get.back();
        CustomSnackBar.showCustomSnackBar(
          title: "Success",
          message: "Address saved succeessfully",
        );
        Get.find<ProfileController>().getAddressList();
      },
      onError: (error) {
        Logger().d(error.toString());
        CustomSnackBar.showCustomSnackBar(
          title: "Failed",
          message: "Invalid Credentials",
        );
        isAddressLoading.value = false;
      },
    );
  }
}
