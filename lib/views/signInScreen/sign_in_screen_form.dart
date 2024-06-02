import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_strings.dart';
import '../../viewModels/authentication_view_model.dart';
import '../widgets/app_textfield.dart';

class SignInScreenForm extends StatelessWidget {
  final TextEditingController emailTEController;
  final TextEditingController passwordTEController;
  final GlobalKey<FormState> formKey;
  final FocusNode emailFocusNode, passwordFocusNode;
  final double screenWidth;

  const SignInScreenForm(
      {super.key,
      required this.emailTEController,
      required this.passwordTEController,
      required this.formKey,
      required this.emailFocusNode,
      required this.passwordFocusNode,
      required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            focusNode: emailFocusNode,
            controller: emailTEController,
            hintText: AppStrings.emailTextFieldHint,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
          ),
          const Gap(15),
          Consumer<AuthenticationViewModel>(
            builder: (_, viewModel, __) => AppTextField(
              focusNode: passwordFocusNode,
              controller: passwordTEController,
              hintText: AppStrings.passwordTextFieldHint,
              suffixIcon: getPasswordFieldIcon(viewModel),
              isObscureText: viewModel.isPasswordObscure,
            ),
          ),
          const Gap(20),
          SizedBox(
            width: screenWidth * 0.9,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  IconButton getPasswordFieldIcon(
      AuthenticationViewModel viewModel) {
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
