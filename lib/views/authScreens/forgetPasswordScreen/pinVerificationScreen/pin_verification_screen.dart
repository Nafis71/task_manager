import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';
import 'package:task_manager/views/authScreens/forgetPasswordScreen/pinVerificationScreen/pin_verification_form.dart';
import 'package:task_manager/views/widgets/app_snackbar.dart';
import 'package:task_manager/views/widgets/forget_password_layout.dart';

import '../../../../utils/app_routes.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  late final List<TextEditingController> pinTEControllers;

  late final List<FocusNode> focusNodes;
  late GlobalKey<FormState> _formKey;

  final double textFieldHeight = 50;

  @override
  void initState() {
    pinTEControllers = List.generate(6, (index) => TextEditingController());
    focusNodes = List.generate(6, (index) => FocusNode());
    _formKey = GlobalKey<FormState>();
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
            headerText: AppStrings.pinVerificationHeaderText,
            bodyText: AppStrings.pinVerificationBodyText,
            screenWidth: screenWidth,
            buttonWidget: const Text(
              AppStrings.pinVerificationButtonText,
            ),
            onButtonPressed: (value) {
              if (_formKey.currentState!.validate()) {
                initiatePinVerification();
                return;
              }
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(getSnackBar(
                    title: AppStrings.emptyPinVerificationFieldTitle,
                    content: AppStrings.emptyPinVerificationFieldMessage,
                    contentType: ContentType.warning,
                    color: AppColor.snackBarWarningColor));
            },
            child: PinVerificationForm(
              formKey: _formKey,
              textFieldWidth: (orientation == Orientation.portrait)
                  ? screenWidth * 0.11
                  : screenWidth * 0.09,
              pinTEControllers: pinTEControllers,
              focusNodes: focusNodes,
            ),
          );
        },
      ),
    );
  }

  Future<void> initiatePinVerification() async {
    String otp = "";
    for (TextEditingController controller in pinTEControllers) {
      otp = otp + controller.text.trim();
    }
    bool status = await context.read<AuthViewModel>().verifyOTP(otp);
    if (status && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.setPasswordScreen);
      return;
    }
    if (mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(getSnackBar(
            title: AppStrings.wrongPinVerificationFieldTitle,
            content: AppStrings.wrongPinVerificationFieldMessage,
            contentType: ContentType.failure,
            color: AppColor.snackBarFailureColor));
    }
  }

  @override
  void dispose() {
    for (TextEditingController controller in pinTEControllers) {
      controller.dispose();
    }
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
