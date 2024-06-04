import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../viewModels/auth_view_model.dart';
import 'app_routes.dart';

class AppNavigation {
  static void gotoSignIn(BuildContext context) {
    AuthViewModel authViewModel =
        Provider.of<AuthViewModel>(context, listen: false);
    authViewModel.setPasswordObscure = true;
    Navigator.pop(context);
  }

  static void gotoSignUp(BuildContext context, FocusNode emailFocusNode,
      FocusNode passwordFocusNode) {
    AuthViewModel authViewModel =
        Provider.of<AuthViewModel>(context, listen: false);
    authViewModel.setPasswordObscure = true;
    Navigator.pushNamed(context, AppRoutes.signUpScreen).then((value) {
      emailFocusNode.unfocus();
      passwordFocusNode.unfocus();
    });
  }
}
