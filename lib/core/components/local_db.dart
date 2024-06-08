import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();
  // get storage
  static late SharedPreferences _sharedPreferences;
  static const String _showOnboard = 'show_onboarding';
  static const String _token = 'token';

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  static Future<void> setOnboardingStatus(bool token) => _sharedPreferences.setBool(_showOnboard, token);
  static Future<void> setToken(String token) => _sharedPreferences.setString(_token, token);

  static bool? getOnboardingStatus() => _sharedPreferences.getBool(_showOnboard);
  static String? getToken() => _sharedPreferences.getString(_token);

  static Future<void> clear() async => await _sharedPreferences.clear();
}
