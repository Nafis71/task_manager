import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_strings.dart';
import '../../../viewModels/auth_view_model.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/circular_progressbar.dart';

class SignInScreenForm extends StatelessWidget {
  final TextEditingController emailTEController;
  final TextEditingController passwordTEController;
  final GlobalKey<FormState> formKey;
  final FocusNode emailFocusNode, passwordFocusNode;
  final double screenWidth;
  final Function initiateSignIn;

  const SignInScreenForm(
      {super.key,
      required this.emailTEController,
      required this.passwordTEController,
      required this.formKey,
      required this.emailFocusNode,
      required this.passwordFocusNode,
      required this.screenWidth,
      required this.initiateSignIn});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            inputType: TextInputType.emailAddress,
            focusNode: emailFocusNode,
            controller: emailTEController,
            hintText: AppStrings.emailTextFieldHint,
            regEx: AppStrings.emailRegEx,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            errorText: AppStrings.emailErrorText,
          ),
          const Gap(15),
          Consumer<AuthViewModel>(
            builder: (_, viewModel, __) => AppTextField(
              inputType: TextInputType.visiblePassword,
              focusNode: passwordFocusNode,
              controller: passwordTEController,
              hintText: AppStrings.passwordTextFieldHint,
              suffixIcon: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  viewModel.setPasswordObscure = !viewModel.isPasswordObscure;
                },
                child: (viewModel.isPasswordObscure)
                    ? const Icon(Icons.visibility,
                        color: AppColor.appPrimaryColor)
                    : const Icon(Icons.visibility_off,
                        color: AppColor.appPrimaryColor),
              ),
              isObscureText: viewModel.isPasswordObscure,
              errorText: AppStrings.passwordErrorText,
            ),
          ),
          const Gap(20),
          SizedBox(
            width: screenWidth * 0.9,
            child: Consumer<AuthViewModel>(
              builder: (_, viewModel, __) {
                return ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        !viewModel.isLoading) {
                      initiateSignIn();
                    }
                    FocusScope.of(context).unfocus();
                  },
                  child: viewModel.isLoading
                      ? const CircularProgressbar(
                          color: AppColor.circularProgressbarColor)
                      : const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 30,
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
