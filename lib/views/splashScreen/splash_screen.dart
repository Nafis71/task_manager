import 'package:flutter/material.dart';
import 'package:task_manager/utils/assets.dart';
import 'package:task_manager/widgets/background_widget.dart';
import 'package:task_manager/wrappers/svg_image_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return const Scaffold(
      body: BackgroundWidget(
        childWidget: Center(
          child: SVGImageLoader(
            asset: Assets.logo,
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}
