import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';
import 'package:task_manager/views/widgets/app_snackbar.dart';
import 'package:task_manager/views/widgets/app_textfield.dart';
import 'package:task_manager/views/widgets/forget_password_layout.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  late final TextEditingController _passwordTEController;
  late final TextEditingController _confirmPasswordTEController;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _passwordTEController = TextEditingController();
    _confirmPasswordTEController = TextEditingController();
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
            headerText: AppStrings.setPasswordHeaderText,
            bodyText: AppStrings.setPasswordBodyText,
            screenWidth: screenWidth,
            buttonWidget: const Text(AppStrings.setPasswordButtonText),
            onButtonPressed: (value) {
              if (_formKey.currentState!.validate()) {
                initiatePasswordReset();
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordTEController,
                    inputType: TextInputType.text,
                    hintText: AppStrings.passwordTextFieldHint,
                    errorText: AppStrings.passwordErrorText,
                    setCustomValidation: true,
                    customValidation: (String value) {
                      if (_passwordTEController.text.length < 8 ||
                          value.isEmpty) {
                        return AppStrings.passwordLengthErrorText;
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        FocusScope.of(context)
                            .requestFocus(_confirmPasswordFocusNode);
                      }
                    },
                  ),
                  const Gap(10),
                  AppTextField(
                    focusNode: _confirmPasswordFocusNode,
                    controller: _confirmPasswordTEController,
                    inputType: TextInputType.text,
                    hintText: AppStrings.confirmPassTextFieldHint,
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    setCustomValidation: true,
                    customValidation: (String value) {
                      if (value.isEmpty) {
                        return AppStrings.confirmPasswordErrorText;
                      }
                      if (_passwordTEController.text !=
                          _confirmPasswordTEController.text) {
                        return AppStrings.confirmPasswordErrorText;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> initiatePasswordReset() async {
    bool status = await context
        .read<AuthViewModel>()
        .resetPassword(_passwordTEController.text.trim());
    if (status && mounted) {
      AppSnackBar().showSnackBar(title: AppStrings.resetPasswordSuccessTitle,
          content: AppStrings.resetPasswordSuccessMessage,
          contentType: ContentType.success,
          color: AppColor.snackBarSuccessColor,
          context: context);
      Navigator.pop(context);
      return;
    }
    if (mounted) {
      Failure failure = context.read<AuthViewModel>().response as Failure;
      AppSnackBar().showSnackBar(title: AppStrings.resetPasswordFailureTitle,
          content: failure.message,
          contentType: ContentType.failure,
          color: AppColor.snackBarFailureColor,
          context: context);
    }
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    _confirmPasswordFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
