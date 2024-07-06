import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/themes/theme_changer.dart';

import '../../wrappers/svg_image_loader.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget childWidget;

  const BackgroundWidget({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Consumer<ThemeChanger>(
              builder: (_, viewModel, __) {
                return SVGImageLoader(
                  asset: viewModel.getBackgroundImage(context),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                );
              },
            ),
          ),
          childWidget,
        ],
      ),
    );
  }
}
