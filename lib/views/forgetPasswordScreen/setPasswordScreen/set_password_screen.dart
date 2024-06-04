import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager/utils/app_strings.dart';
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

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _passwordTEController = TextEditingController();
    _confirmPasswordTEController = TextEditingController();
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
            onPressed: (value) {},
            child: Form(
              child: Column(
                children: [
                  AppTextField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordTEController,
                    inputType: TextInputType.text,
                    hintText: AppStrings.passwordTextFieldHint,
                    errorText: AppStrings.passwordErrorText,
                    onFieldSubmitted: (value){
                      if(value.isNotEmpty){
                        FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                      }
                    },
                  ),
                  const Gap(10),
                  AppTextField(
                    focusNode: _confirmPasswordFocusNode,
                    controller: _confirmPasswordTEController,
                    inputType: TextInputType.text,
                    hintText: AppStrings.confirmPassTextFieldHint,
                    errorText: AppStrings.confirmPasswordErrorText,
                    onFieldSubmitted: (value){
                      if(value.isNotEmpty){
                        FocusScope.of(context).unfocus();
                      }
                    },
                    setCustomValidation: true,
                    customValidation: (String value){
                      if(value.isNotEmpty && (_passwordTEController.text != _confirmPasswordTEController.text)){
                        return false;
                      }
                      return true;
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

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    _confirmPasswordFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}