import 'package:flutter/material.dart';
import 'package:task_manager/utils/assets.dart';
import 'package:task_manager/utils/routes.dart';
import 'package:task_manager/widgets/background_widget.dart';
import 'package:task_manager/wrappers/svg_image_loader.dart';
import 'package:task_manager/wrappers/widget_custom_animator.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.signInScreen);
    });
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
              asset: Assets.logo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
