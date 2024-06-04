import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_navigation.dart';
import 'package:task_manager/utils/app_routes.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';
import 'package:task_manager/views/widgets/app_elevated_button.dart';
import 'package:task_manager/views/widgets/app_textfield.dart';
import 'package:task_manager/views/widgets/background_widget.dart';
import 'package:task_manager/views/widgets/forget_password_layout.dart';

import '../../../utils/app_color.dart';
import '../../widgets/circular_progressbar.dart';
import '../../widgets/sign_in_bottom_text.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailTEController;
  late final FocusNode _emailFocusNode;

  @override
  void initState() {
    _emailTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return ForgetPasswordLayout(
            orientation: orientation,
            horizontalMargin: screenWidth * 0.1,
            verticalMargin: (orientation == Orientation.portrait)
                ? screenHeight * 0.25
                : screenHeight * 0.15,
            headerText: AppStrings.emailVerificationHeaderText,
            bodyText: AppStrings.emailVerificationBodyText,
            screenWidth: screenWidth,
            buttonWidget: Consumer<AuthViewModel>(
              builder: (_, viewModel, __) {
                return (viewModel.isLoading)
                    ? const CircularProgressbar(
                    color: AppColor.circularProgressbarColor)
                    : const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 30,
                );
              },
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.pinVerificationScreen);
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    focusNode: _emailFocusNode,
                    controller: _emailTEController,
                    hintText: AppStrings.emailTextFieldHint,
                    inputType: TextInputType.emailAddress,
                    errorText: AppStrings.emailErrorText,
                    regEx: AppStrings.emailRegEx,
                  ),
                  const Gap(20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
