import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/auth_controller.dart';
import 'package:food/core/controllers/cart_controller.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:food/core/controllers/profile_controller.dart';
import 'package:food/views/auth/login_page.dart';
import 'package:food/views/onboarding/onboarding_page.dart';
import 'package:get/get.dart';
import 'core/components/local_db.dart';
import 'core/themes/app_themes.dart';
import 'views/parent/parent_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await MySharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(427, 930),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        late bool intoOnboard = MySharedPref.getOnboardingStatus() ?? true;
        late String intoAuth = MySharedPref.getToken() ?? '';
        late Widget initPage = const OnboardingPage();
        if (intoOnboard) {
          initPage = const OnboardingPage();
        } else if (intoAuth.isEmpty) {
          initPage = const LoginPage();
        } else {
          initPage = const ParentPage();
        }
        return GetMaterialApp(
          title: 'FoodApp',
          onInit: () {
            Get.lazyPut(() => AuthController(intoAuth));
            Get.lazyPut(() => ProfileController());
            Get.lazyPut(() => HomeController());
            Get.lazyPut(() => CartController());

          },


          debugShowCheckedModeBanner: false,
          theme: AppTheme.defaultTheme,
          onGenerateRoute: (settings) {
            final routes = <String, WidgetBuilder>{};
            WidgetBuilder? builder = routes[settings.name];
            return MaterialPageRoute(builder: (context) => builder!(context));
          },
          home: initPage,


        );
      },
    );
  }
}
