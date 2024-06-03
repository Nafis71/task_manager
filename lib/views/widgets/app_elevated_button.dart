import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../viewModels/auth_view_model.dart';
import 'circular_progressbar.dart';

class AppElevatedButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final double screenWidth;
  final Function onPressed;
  final Widget childWidget;

  const AppElevatedButton(
      {super.key,
      required this.formKey,
      required this.screenWidth,
      required this.childWidget,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.9,
      height: 45,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: childWidget,
      ),
    );
  }
}
