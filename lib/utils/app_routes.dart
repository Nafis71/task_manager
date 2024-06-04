import 'package:flutter/material.dart';
import 'package:task_manager/views/dashboardScreen/dashboard_screen.dart';
import 'package:task_manager/views/forgetPasswordScreen/emailVerificationScreen/email_verification_screen.dart';
import 'package:task_manager/views/forgetPasswordScreen/setPasswordScreen/set_password_screen.dart';
import 'package:task_manager/views/signInScreen/sign_in_screen.dart';
import 'package:task_manager/views/signUpScreen/sign_up_screen.dart';
import 'package:task_manager/views/splashScreen/splash_screen.dart';

import '../views/forgetPasswordScreen/pinVerificationScreen/pin_verification_screen.dart';

class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const signInScreen = "/signInScreen";
  static const signUpScreen = "/signUpScreen";
  static const dashboardScreen = "/dashboardScreen";
  static const emailVerificationScreen = "/emailVerificationScreen";
  static const pinVerificationScreen = "/pinVerificationScreen";
  static const setPasswordScreen = "/setPasswordScreen";

  static MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    final Map<String, WidgetBuilder> routes = {
      splashScreen: (context) => const SplashScreen(),
      signInScreen: (context) => const SignInScreen(),
      signUpScreen: (context) => const SignUpScreen(),
      dashboardScreen: (context) => const DashboardScreen(),
      emailVerificationScreen: (context) => const EmailVerificationScreen(),
      pinVerificationScreen: (context) => const PinVerificationScreen(),
      setPasswordScreen: (context) => const SetPasswordScreen(),
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
