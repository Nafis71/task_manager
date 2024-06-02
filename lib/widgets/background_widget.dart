import 'package:flutter/material.dart';

import '../utils/assets.dart';
import '../wrappers/svg_image_loader.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget childWidget;

  const BackgroundWidget({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SVGImageLoader(
            asset: Assets.backgroundImage,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          childWidget,
        ],
      ),
    );
  }
}
