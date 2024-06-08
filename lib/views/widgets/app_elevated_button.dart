import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/auth_view_model.dart';

class AppElevatedButton extends StatelessWidget {
  final double screenWidth;
  final Function(AuthViewModel viewModel) onPressed;
  final Widget loadingChild, placeHolderChild;

  const AppElevatedButton(
      {super.key,
      required this.screenWidth,
      required this.onPressed,
      required this.loadingChild,
      required this.placeHolderChild});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.9,
      height: 45,
      child: Consumer<AuthViewModel>(
        builder: (_,viewModel, __) {
          return ElevatedButton(
            onPressed: () => onPressed(viewModel),
            child: (viewModel.isLoading) ? loadingChild : placeHolderChild,
          );
        },
      ),
    );
  }
}
