import 'package:flutter/material.dart';
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
    return GetMaterialApp(
      title: 'FoodApp',
      theme: AppTheme.defaultTheme,
      onGenerateRoute: (settings) {
        final routes = <String, WidgetBuilder>{};
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (context) => builder!(context));
      },
      home: LoginPage(),
    );
  }
}
