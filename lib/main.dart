import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/core/controllers/auth_controller.dart';
import 'package:food/core/controllers/home_controller.dart';
import 'package:food/views/parent/parent_page.dart';
import 'package:get/get.dart';
import 'package:food/views/auth/login_page.dart';
import 'core/themes/app_themes.dart';

void main() {
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
        return GetMaterialApp(
          title: 'FoodApp',
          onInit: () {
            Get.put(AuthController());
            Get.put(HomeController());
          },
          debugShowCheckedModeBanner: false,
          theme: AppTheme.defaultTheme,
          onGenerateRoute: (settings) {
            final routes = <String, WidgetBuilder>{};
            WidgetBuilder? builder = routes[settings.name];
            return MaterialPageRoute(builder: (context) => builder!(context));
          },
          home: const ParentPage(),
        );
      },
    );
  }
}
