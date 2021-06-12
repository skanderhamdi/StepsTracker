import 'package:flutter/material.dart';
import 'package:steps_tracker/views/main_layout/login_screen.dart';
import 'package:steps_tracker/views/main_layout/main_tabview.dart';
import 'package:steps_tracker/views/main_layout/splash_screen.dart';

class CustomRouter {

  static const String splashScreen = "splash_screen";
  static const String loginScreen = "login_screen";
  static const String tabView = "tab_view";

  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case tabView:
        return MaterialPageRoute(builder: (_) => MainTabView());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}

class CustomMaterialPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);
  CustomMaterialPageRoute({builder}) : super(builder: builder);
}