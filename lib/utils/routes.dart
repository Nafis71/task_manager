import 'package:flutter/material.dart';
import 'package:task_manager/views/signInScreen/sign_in_screen.dart';
import 'package:task_manager/views/splashScreen/splash_screen.dart';

class Routes {
  static const splashScreen = "/splashScreen";
  static const signInScreen = "/signInScreen";

  static MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    final Map<String, WidgetBuilder> routes = {
      splashScreen: (context) => const SplashScreen(),
      signInScreen: (context) => const SignInScreen(),
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
