import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/views/widgets/background_widget.dart';
import 'package:task_manager/views/widgets/sign_in_bottom_text.dart';

import '../../viewModels/auth_view_model.dart';
import 'app_elevated_button.dart';

class ForgetPasswordLayout extends StatelessWidget {
  final double horizontalMargin, verticalMargin;
  final double screenWidth;
  final Orientation orientation;
  final Widget child, buttonWidget;
  final String headerText, bodyText;
  final Function onPressed;

  const ForgetPasswordLayout(
      {super.key,
      required this.orientation,
      required this.child,
      required this.horizontalMargin,
      required this.verticalMargin,
      required this.headerText,
      required this.bodyText,
      required this.screenWidth,
      required this.buttonWidget,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      childWidget: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headerText,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Gap(5),
              Text(
                bodyText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Gap(20),
              child,
              const Gap(20),
              Consumer<AuthViewModel>(builder: (_, viewModel, __) {
                return AppElevatedButton(
                  screenWidth: screenWidth,
                  childWidget: buttonWidget,
                  onPressed: () => onPressed(),
                );
              }),
              const Gap(30),
              SignInBottomText(route: (){
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
