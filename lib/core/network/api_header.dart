import '../components/local_db.dart';

class Header {
  // SECURE HEADER
  static Map<String, dynamic> secureHeader = {
    "Authorization": "Bearer ${MySharedPref.getToken()}",
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

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
}
