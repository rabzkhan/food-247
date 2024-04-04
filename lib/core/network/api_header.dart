import 'package:food/core/controllers/auth_controller.dart';

class Header {
  // SECURE HEADER
  static Map<String, dynamic> secureHeader() {
    return {
        "Authorization": "Bearer ${AuthController.to.token}",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  // DEFAULT HEADER
  static Map<String, dynamic> defaultHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // DEFAULT MULTIPART-HEADER
  static Map<String, dynamic> defaultMultipartHeader = {
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
  };

  // SECURE MULTIPART HEADER
  static Map<String, dynamic> secureMultipartHeader = {
    "Authorization": "Bearer 'token'",
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
  };

  /// ***************** CUSTOM API HEADER ***************** ///
  ///
  static Map<String, dynamic> customApiHeader = {
    "token": "2dca61e34574f10a3e4b1cf70988e36f",
  };
}
