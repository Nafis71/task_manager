import 'package:flutter/material.dart';
import 'package:task_manager/views/dashboardScreen/dashboard_screen.dart';
import 'package:task_manager/views/newTaskAddScreen/add_task_screen.dart';
import 'package:task_manager/views/splashScreen/splash_screen.dart';
import 'package:task_manager/views/updateProfileScreen/updateProfileScreen.dart';

import '../views/authScreens/forgetPasswordScreen/emailVerificationScreen/email_verification_screen.dart';
import '../views/authScreens/forgetPasswordScreen/pinVerificationScreen/pin_verification_screen.dart';
import '../views/authScreens/forgetPasswordScreen/setPasswordScreen/set_password_screen.dart';
import '../views/authScreens/signInScreen/sign_in_screen.dart';
import '../views/authScreens/signUpScreen/sign_up_screen.dart';

class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const signInScreen = "/signInScreen";
  static const signUpScreen = "/signUpScreen";
  static const dashboardScreen = "/dashboardScreen";
  static const emailVerificationScreen = "/emailVerificationScreen";
  static const pinVerificationScreen = "/pinVerificationScreen";
  static const setPasswordScreen = "/setPasswordScreen";
  static const addTaskScreen = "/addTaskScreen";
  static const updateProfileScreen = "/updateProfileScreen";

  static MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    final Map<String, WidgetBuilder> routes = {
      splashScreen: (context) => const SplashScreen(),
      signInScreen: (context) => const SignInScreen(),
      signUpScreen: (context) => const SignUpScreen(),
      dashboardScreen: (context) => const DashboardScreen(),
      emailVerificationScreen: (context) => const EmailVerificationScreen(),
      pinVerificationScreen: (context) => const PinVerificationScreen(),
      setPasswordScreen: (context) => const SetPasswordScreen(),
      addTaskScreen: (context) => const AddTaskScreen(),
      updateProfileScreen: (context) => const UpdateProfileScreen(),
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
