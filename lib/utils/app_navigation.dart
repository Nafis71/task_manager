import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app.dart';
import '../viewModels/auth_view_model.dart';
import 'app_routes.dart';

class AppNavigation extends AuthViewModel {
  static AppNavigation? _instance;

  AppNavigation._();

  factory AppNavigation() {
    //singleton pattern
    _instance ??= AppNavigation._();
    return _instance!;
  }

  void gotoSignIn() {
    setPasswordObscure = true;
    Navigator.pop(TaskManager.navigatorKey.currentContext!);
  }

  void gotoSignUp(FocusNode emailFocusNode, FocusNode passwordFocusNode) {
    setPasswordObscure = true;
    Navigator.pushNamed(
            TaskManager.navigatorKey.currentContext!, AppRoutes.signUpScreen)
        .then((value) {
      emailFocusNode.unfocus();
      passwordFocusNode.unfocus();
    });
  }

  Future<void> signOutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushNamedAndRemoveUntil(TaskManager.navigatorKey.currentContext!,
        AppRoutes.signInScreen, (route) => false);
  }
}
