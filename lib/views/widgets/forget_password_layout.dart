import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/views/widgets/background_widget.dart';
import 'package:task_manager/views/widgets/sign_in_bottom_text.dart';
import '../../utils/app_color.dart';
import '../../viewModels/auth_view_model.dart';
import 'circular_progressbar.dart';

class ForgetPasswordLayout extends StatelessWidget {
  final double horizontalMargin, verticalMargin;
  final double screenWidth;
  final Orientation orientation;
  final Widget child, buttonWidget;
  final String headerText, bodyText;
  final Function(AuthViewModel viewModel) onButtonPressed;

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
      required this.onButtonPressed});

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
              SizedBox(
                  width: screenWidth * 0.9,
                  child: Consumer<AuthViewModel>(
                    builder: (_, viewModel, __) {
                      return ElevatedButton(
                          onPressed: () => onButtonPressed(viewModel),
                          child: viewModel.isLoading
                              ? const CircularProgressbar(
                                  color: AppColor.circularProgressbarColor)
                              : buttonWidget);
                    },
                  )),
              const Gap(30),
              SignInBottomText(route: () {
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
