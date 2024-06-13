import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/loginModels/user_data.dart';
import 'package:task_manager/utils/app_assets.dart';
import 'package:task_manager/utils/app_routes.dart';
import 'package:task_manager/viewModels/user_view_model.dart';
import 'package:task_manager/wrappers/svg_image_loader.dart';
import 'package:task_manager/wrappers/widget_custom_animator.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      if (token != null && !JwtDecoder.isExpired(token) && mounted) {
        await loadUserData(preferences);
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, AppRoutes.dashboardScreen);
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          if(mounted){
            Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
          }
        });
      }
    }catch(exception){
      if(kDebugMode){
        debugPrint(exception.toString());
      }
    }

  }

  Future<void> loadUserData(SharedPreferences preferences) async {
    UserViewModel viewModel = Provider.of<UserViewModel>(context,listen: false);
    viewModel.setToken = preferences.getString("token")!;
    viewModel.setUserData = UserData(
      email: preferences.getString("email"),
      firstName: preferences.getString("firstName"),
      lastName: preferences.getString("lastName"),
      mobile: preferences.getString("mobile"),
      photo: preferences.getString("photo"),
      password: preferences.getString("password"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        childWidget: Center(
          child: WidgetCustomAnimator(
            incomingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(
                duration: const Duration(seconds: 2), scale: 0.3),
            childWidget: const SVGImageLoader(
              asset: AppAssets.logo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
