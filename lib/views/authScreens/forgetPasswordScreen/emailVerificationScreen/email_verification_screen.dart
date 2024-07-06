import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_routes.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';
import 'package:task_manager/views/widgets/app_snackbar.dart';
import 'package:task_manager/views/widgets/app_textfield.dart';
import 'package:task_manager/views/widgets/forget_password_layout.dart';

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
            buttonWidget: const Icon(
              Icons.arrow_circle_right_outlined,
              size: 30,
            ),
            onButtonPressed: (value) {
              if (_formKey.currentState!.validate()) {
                initiateOTPSending();
              }
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

  Future<void> initiateOTPSending() async {
    bool status = await context
        .read<AuthViewModel>()
        .sendOTP(_emailTEController.text.trim());
    if (status && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.pinVerificationScreen);
      return;
    }
    if (mounted) {
      int statusCode = (context.read<AuthViewModel>().response as Failure).statusCode;
      AppSnackBar().showSnackBar(title: AppStrings.sendOTPFailureTitle,
          content: (statusCode == 600)? AppStrings.serverConnectionErrorText : AppStrings.sendOTPFailureMessage,
          contentType: ContentType.failure,
          color: AppColor.snackBarFailureColor,
          context: context);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
