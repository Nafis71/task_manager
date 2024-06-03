import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/views/widgets/circular_progressbar.dart';

import '../../utils/app_color.dart';
import '../../utils/app_strings.dart';
import '../../viewModels/auth_view_model.dart';
import '../widgets/app_textfield.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController emailTEController;
  final TextEditingController passwordTEController;
  final TextEditingController firstNameTEController;
  final TextEditingController lastNameTEController;
  final TextEditingController mobileNumberTEController;
  final GlobalKey<FormState> formKey;
  final FocusNode emailFocusNode,
      passwordFocusNode,
      firstNameFocusNode,
      lastNameFocusNode,
      mobileNumberFocusNode;
  final Function registerUser;
  final double screenWidth;

  const SignUpForm(
      {super.key,
      required this.emailTEController,
      required this.passwordTEController,
      required this.formKey,
      required this.emailFocusNode,
      required this.passwordFocusNode,
      required this.screenWidth,
      required this.firstNameTEController,
      required this.lastNameTEController,
      required this.mobileNumberTEController,
      required this.firstNameFocusNode,
      required this.lastNameFocusNode,
      required this.mobileNumberFocusNode,
      required this.registerUser});

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
              FocusScope.of(context).requestFocus(firstNameFocusNode);
            },
            errorText: AppStrings.emailErrorText,
          ),
          const Gap(15),
          AppTextField(
            inputType: TextInputType.name,
            focusNode: firstNameFocusNode,
            controller: firstNameTEController,
            hintText: AppStrings.firstNameTextFieldHint,
            regEx: AppStrings.nameRegEX,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(lastNameFocusNode);
            },
            errorText: AppStrings.firstNameErrorText,
          ),
          const Gap(15),
          AppTextField(
            inputType: TextInputType.name,
            focusNode: lastNameFocusNode,
            controller: lastNameTEController,
            hintText: AppStrings.lastNameTextFieldHint,
            regEx: AppStrings.nameRegEX,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(mobileNumberFocusNode);
            },
            errorText: AppStrings.lastNameErrorText,
          ),
          const Gap(15),
          AppTextField(
            inputType: TextInputType.number,
            focusNode: mobileNumberFocusNode,
            controller: mobileNumberTEController,
            hintText: AppStrings.mobileNumberTextFieldHint,
            regEx: AppStrings.digitsRegEx,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            errorText: AppStrings.mobileNumberErrorText,
          ),
          const Gap(15),
          Consumer<AuthViewModel>(
            builder: (_, viewModel, __) => AppTextField(
              inputType: TextInputType.visiblePassword,
              focusNode: passwordFocusNode,
              controller: passwordTEController,
              hintText: AppStrings.passwordTextFieldHint,
              suffixIcon: getPasswordFieldIcon(viewModel),
              isObscureText: viewModel.isPasswordObscure,
              errorText: AppStrings.passwordErrorText,
            ),
          ),
          const Gap(20),
          SizedBox(
            width: screenWidth * 0.9,
            height: 45,
            child: Consumer<AuthViewModel>(
              builder: (_, viewModel, __) {
                return ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        !viewModel.isLoading) {
                      registerUser();
                    }
                    FocusScope.of(context).unfocus();
                  },
                  child: (viewModel.isLoading)
                      ? const CircularProgressbar(
                          color: AppColor.circularProgressbarColor)
                      : const Icon(Icons.arrow_circle_right_outlined, size: 30),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  IconButton getPasswordFieldIcon(AuthViewModel viewModel) {
    IconData icon;
    (viewModel.isPasswordObscure)
        ? icon = Icons.visibility
        : icon = Icons.visibility_off;
    return IconButton(
      splashColor: Colors.transparent,
      onPressed: () {
        (viewModel.isPasswordObscure)
            ? viewModel.setPasswordObscure = false
            : viewModel.setPasswordObscure = true;
      },
      icon: Icon(icon, color: AppColor.appPrimaryColor),
    );
  }
}
