import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_strings.dart';
import '../../viewModels/user_view_model.dart';
import '../widgets/app_textfield.dart';
import '../widgets/circular_progressbar.dart';

class UpdateProfileScreenForm extends StatelessWidget {
  final TextEditingController emailTEController,
      firstNameTEController,
      lastNameTEController,
      mobileNumberTEController,
      passwordTEController;
  final GlobalKey<FormState> formKey;
  final FocusNode emailFocusNode,
      passwordFocusNode,
      firstNameFocusNode,
      lastNameFocusNode,
      mobileNumberFocusNode;
  final Function(UserViewModel viewModel) onPressed;

  const UpdateProfileScreenForm(
      {super.key,
      required this.emailTEController,
      required this.firstNameTEController,
      required this.lastNameTEController,
      required this.mobileNumberTEController,
      required this.passwordTEController,
      required this.formKey,
      required this.emailFocusNode,
      required this.passwordFocusNode,
      required this.firstNameFocusNode,
      required this.lastNameFocusNode,
      required this.mobileNumberFocusNode,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            focusNode: emailFocusNode,
            controller: emailTEController,
            inputType: TextInputType.emailAddress,
            hintText: AppStrings.emailTextFieldHint,
            errorText: AppStrings.emailErrorText,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(firstNameFocusNode);
            },
            labelText: AppStrings.emailTextFieldHint,
          ),
          const Gap(20),
          AppTextField(
            focusNode: firstNameFocusNode,
            controller: firstNameTEController,
            inputType: TextInputType.text,
            hintText: AppStrings.firstNameTextFieldHint,
            errorText: AppStrings.firstNameErrorText,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(lastNameFocusNode);
            },
            labelText: AppStrings.firstNameTextFieldHint,
          ),
          const Gap(20),
          AppTextField(
            focusNode: lastNameFocusNode,
            controller: lastNameTEController,
            inputType: TextInputType.text,
            hintText: AppStrings.lastNameTextFieldHint,
            errorText: AppStrings.lastNameErrorText,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(mobileNumberFocusNode);
            },
            labelText: AppStrings.lastNameTextFieldHint,
          ),
          const Gap(20),
          AppTextField(
            focusNode: mobileNumberFocusNode,
            controller: mobileNumberTEController,
            inputType: TextInputType.number,
            hintText: AppStrings.mobileNumberTextFieldHint,
            errorText: AppStrings.mobileNumberErrorText,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            labelText: AppStrings.mobileNumberTextFieldHint,
          ),
          const Gap(20),
          Consumer<UserViewModel>(
            builder: (_, viewModel, __) => AppTextField(
              focusNode: passwordFocusNode,
              controller: passwordTEController,
              isObscureText: viewModel.isPasswordObscured,
              suffixIcon: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  viewModel.setIsPasswordObscured =
                      !viewModel.isPasswordObscured;
                },
                child: (viewModel.isPasswordObscured)
                    ? const Icon(Icons.visibility,
                        color: AppColor.appPrimaryColor)
                    : const Icon(Icons.visibility_off,
                        color: AppColor.appPrimaryColor),
              ),
              inputType: TextInputType.text,
              hintText: AppStrings.passwordTextFieldHint,
              errorText: AppStrings.passwordErrorText,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
              labelText: AppStrings.passwordTextFieldHint,
            ),
          ),
          const Gap(20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Consumer<UserViewModel>(
              builder: (_, viewModel, __) {
                return ElevatedButton(
                  onPressed: () => onPressed(viewModel),
                  child: viewModel.isLoading
                      ? const CircularProgressbar(
                          color: AppColor.circularProgressbarColor)
                      : const Icon(Icons.arrow_circle_right_outlined, size: 30),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
