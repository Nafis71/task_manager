import 'package:flutter/material.dart';
import 'package:task_manager/views/signInScreen/sign_in_screen.dart';
import 'package:task_manager/views/signUpScreen/sign_up_screen.dart';
import 'package:task_manager/views/splashScreen/splash_screen.dart';

class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const signInScreen = "/signInScreen";
  static const signUpScreen = "/signUpScreen";

  static MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    final Map<String, WidgetBuilder> routes = {
      splashScreen: (context) => const SplashScreen(),
      signInScreen: (context) => const SignInScreen(),
      signUpScreen: (context) => const SignUpScreen(),
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
